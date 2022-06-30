import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';

class FlutterBlueService {

  // Discoverable UUID
  String peripheralUUID = '5584E296-71D8-481D-83C2-7C08A9E64D02';

  // Slots
  String serviceUUID = 'c83fe52e-0ab5-49d9-9817-98982b4c48a3';
  String serialUUID = '9d77e2cf-5d20-44ea-8d2f-a221b976c605';

  // Cash2Chips
  String c2cAmountUUID = '2d488603-34b2-4640-9831-bde5d0eeff28';
  String c2cErrorUUID = '333932b9-eed9-43ed-83dc-8197ba77c4a3';
  String c2cCancelUUID = 'da9e1da3-684c-4178-b140-9d17e3732769';

  FlutterBlue bleManager = FlutterBlue.instance;
  Map<String, ScanResult> devices = <String, ScanResult>{};

  void init() async {
    bleManager.startScan(timeout: Duration(seconds: 4));
    StreamSubscription<List<ScanResult>> subscription = bleManager.scanResults.listen((results) {
      // we need to do something with the scan results
      for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.rssi}');
      }
    });
    bleManager.stopScan();
  }


  void scanForDevice() async {
    bleManager.scan(

    );
  }

}

