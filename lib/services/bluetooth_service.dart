import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';
//import 'package:flutter_blue/flutter_blue.dart';

class BlueToothServiceProvider with ChangeNotifier {
  //FlutterBlue flutterBlue = FlutterBlue.instance;

  String peripheralUID = '5584E296-71D8-481D-83C2-7C08A9E64D02';

  // String peripheralUID = 'c83fe52e-0ab5-49d9-9817-98982b4c48a3'; // Dealer App mode for testing

  String serviceUUID = 'c83fe52e-0ab5-49d9-9817-98982b4c48a3';
  String serialUUID = '9d77e2cf-5d20-44ea-8d2f-a221b976c605';

  // Cash2Chips
  String c2cAmountUUID = '2d488603-34b2-4640-9831-bde5d0eeff28';
  String c2cErrorUUID = '333932b9-eed9-43ed-83dc-8197ba77c4a3';
  String c2cCancelUUID = 'da9e1da3-684c-4178-b140-9d17e3732769';

  BleManager bleManager = BleManager();
  BluetoothState bluetoothState = BluetoothState.UNKNOWN;
  Map<String, ScanResult> devices = <String, ScanResult>{};
  Map<String, ScanResult?> devicesBySerial = <String, ScanResult?>{};

  late Function(String val)? onTxSerialChangeCallback;
  late Function(int val)? onAmountCallback;
  late Function()? onCancelCallback;

  bool isConnectedToTable = false;

  void init() async {
    await bleManager.createClient(
        restoreStateIdentifier: 'restore-state-identifier',
        restoreStateAction: (List<Peripheral> peripherals) {
          peripherals.forEach((Peripheral peripheral) {
            print('peripheral restored ${peripheral.name}');
          });
        });
    bleManager.observeBluetoothState().listen((BluetoothState btState) {
      print('new bluetooth state: ' + btState.toString());
      bluetoothState = btState;
      if (bluetoothState == BluetoothState.POWERED_ON) {
        _startScanning();
      } else {
        bleManager.stopPeripheralScan();
        print('stopped scanning');
      }
    });
  }

  void _startScanning() {
    if (bluetoothState == BluetoothState.POWERED_ON) {
      print('scanning for peripherals');
      bleManager
          .startPeripheralScan(uuids: <String>[peripheralUID, serviceUUID], allowDuplicates: true)
          .listen((ScanResult scanResult) async {
        // print('Scanned Peripheral ${scanResult.peripheral.name}, RSSI ${scanResult.rssi}');
        devices[scanResult.peripheral.name] = scanResult;
      });
    } else {
      print('unable to start scanning, bluetooth state: ' + bluetoothState.toString());
    }
  }

  Future<String> getNearestDeviceSerialNumber() async {
    final Completer<String> completer = Completer<String>();
    ScanResult? _sr;
    int rssi = -65;
    Peripheral? peripheral;
    bool isGMI = false;
    devices.forEach((_, ScanResult sr) {
      if (sr.rssi > rssi) {
        _sr = sr;
        rssi = sr.rssi;
        peripheral = sr.peripheral;
        isGMI = sr.advertisementData.serviceUuids.contains(peripheralUID);
      }
    });
    if (peripheral != null) {
      print('connecting to ' + peripheral!.name);
      await peripheral!.connect();
      if (await peripheral!.isConnected()) {
        print('connected to ' + peripheral!.name);
        String serial = '';
        if (isGMI) {
          // get serial from GMI BLE
          try {
            print('trying to get serial from a gmi');
            await peripheral!.discoverAllServicesAndCharacteristics(
                transactionId: 'discovery');
            final CharacteristicWithValue event =
                await peripheral!.readCharacteristic(serviceUUID, serialUUID);
            serial = utf8.decode(event.value);
            if (serial != '') {
              devicesBySerial[serial] = _sr;
              completer.complete(serial);
            }
          } catch (e) {}
        } else {
          // get serial from dealer app
          try {
            print('trying to get serial from dealer app');
            await peripheral!.discoverAllServicesAndCharacteristics(
                transactionId: 'discovery');
            final CharacteristicWithValue event =
                await peripheral!.readCharacteristic(serviceUUID, serialUUID);
            serial = utf8.decode(event.value);
            if (serial != '') {
              devicesBySerial[serial] = _sr;
              completer.complete(serial);
            }
          } catch (e) {
            print('error reading serial number');
            print(e);
          }
        }
        if (serial == '') {
          const String e = 'could not find sas serial number';
          print(e);
          completer.completeError(e);
        }
        // disconnect
        try {
          await peripheral!.disconnectOrCancelConnection();
          print('disconnected');
        } catch (e) {
          print('unable to disconnect from peripheral');
        }
      } else {
        const String err = 'could not connect to device';
        print(err);
        completer.completeError(err);
      }
    }
    return completer.future;
  }

  Future<void> c2cConnect(String serial, Function(String val) cb1,
      Function(int val) cb2, Function() cb3) async {
    final Completer<void> completer = Completer<void>();
    if (isConnectedToTable) {
      await c2cDisconnect('table');
      isConnectedToTable = false;
    }
    final ScanResult? sr = devicesBySerial[serial];
    if (sr != null) {
      final Peripheral peripheral = sr.peripheral;
      try {
        print('connecting to ' + serial);
        await peripheral.connect();
        if (await peripheral.isConnected()) {
          isConnectedToTable = true;
          print('is connected');
        }
        try {
          await peripheral.discoverAllServicesAndCharacteristics();
          print('services are discovered');
          try {
            // setup transaction serial number callback/listener
            onTxSerialChangeCallback = cb1;
            peripheral
                .monitorCharacteristic(serviceUUID, serialUUID)
                .listen((CharacteristicWithValue event) {
              final String val = utf8.decode(event.value);
              print('onTxSerialChangeCallback value: ' + val);
              onTxSerialChangeCallback!(val);
            });
            // setup amount callback/listener
            onAmountCallback = cb2;
            peripheral
                .monitorCharacteristic(serviceUUID, c2cAmountUUID)
                .listen((CharacteristicWithValue event) {
              final String val = utf8.decode(event.value);
              print('onAmountCallback value: ' + val);
              final int retVal = int.parse(val);
              onAmountCallback!(retVal);
              if (retVal == -1) {
                onCancelCallback!();
              }
            });
            // setup cancel callback/listener
            onCancelCallback = cb3;
            // peripheral.monitorCharacteristic(serviceUUID, c2cCancelUUID)
            //     .listen((CharacteristicWithValue event) {
            //   onCancelCallback!();
            // });
          } catch (e) {
            print(e);
            completer.completeError('monitorCharacteristic error');
          }
        } catch (e) {
          print(e);
          completer.completeError('discovery error');
        }
        completer.complete(null);
      } catch (e) {
        print(e);
        completer.completeError('error connecting to ' + serial);
      }
    } else {
      completer.completeError('unable to find device with serial ' + serial);
    }
    return completer.future;
  }

  Future<void> c2cDisconnect(String serial) async {
    final Completer<void> completer = Completer<void>();
    onTxSerialChangeCallback = null;
    onAmountCallback = null;
    onCancelCallback = null;
    print('disconnecting');
    if (isConnectedToTable) {
      await devicesBySerial['table']!.peripheral.disconnectOrCancelConnection();
      if (await devicesBySerial['table']!.peripheral.isConnected()) {
        completer.completeError('unable to disconenct');
      } else {
        print('disconnected');
        isConnectedToTable = false;
        completer.complete();
      }
    } else {
      completer.complete();
    }
    return completer.future;
  }

  Future<void> c2cRequestBuyin(String serial, int amt) async {
    try {
      if (amt > 0) {
        print('requesting buying with amount ' + amt.toString());
      } else {
        print('requesting cashout');
      }
      final Completer<void> completer = Completer<void>();
      final ScanResult? sr = devicesBySerial[serial];
      if (sr != null) {
        try {
          await sr.peripheral.discoverAllServicesAndCharacteristics();
          try {
            final String b64 = base64.encode(utf8.encode(amt.toString()));
            print('writing string: ' + b64 + ' to char');
            final Uint8List bytes = Uint8List.fromList(utf8.encode(b64));
            await sr.peripheral
                .writeCharacteristic(serviceUUID, c2cAmountUUID, bytes, true);
            completer.complete();
          } catch (e) {
            completer.completeError('writeCharacteristic error');
            print('exception: $e');
          }
        } catch (e) {
          completer
              .completeError('discoverAllServicesAndCharacteristics error');
          print(e);
        }
      } else {
        completer.completeError('unable to find device ' + serial);
      }
      return completer.future;
    } catch (e) {
      print('exception e');
      return null;
    }
  }

  Future<void> c2cRequestCashout(String serial) async {
    return c2cRequestBuyin(serial, 0);
  }

  Future<void> c2cCancelRequest(String serial) async {
    final Completer<void> completer = Completer<void>();
    final ScanResult? sr = devicesBySerial[serial];
    if (sr != null) {
      try {
        final Uint8List bytes = Uint8List.fromList(utf8.encode('0'));
        print('before await');
        await sr.peripheral
            .writeCharacteristic(serviceUUID, c2cCancelUUID, bytes, true);
        print('after await');
        completer.complete();
      } catch (e) {
        completer.completeError('writeCharacteristic error');
        return completer.future;
      }
    } else {
      completer.completeError('unable to find device with serial ' + serial);
    }
    print('will return a value');
    return completer.future;
  }

  BluetoothState getBluetoothState() {
    return bluetoothState;
  }

  void destroyClient() {
    bleManager.destroyClient();
  }
}
