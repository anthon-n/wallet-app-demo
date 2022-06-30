import 'package:acresapp/models/device_model.dart';
import 'package:acresapp/providers/timer_provider.dart';
import 'package:acresapp/screens/fund_slots_screens/fund_slots_transfer_screen.dart';
import 'package:acresapp/screens/fund_table_screens/fund_table_transfer/fund_table_transfer_screen.dart';
import 'package:acresapp/services/bluetooth_service.dart';
import 'package:acresapp/services/device_service.dart';
import 'package:acresapp/widgets/universal_widgets/alert_pop_up.dart';
import 'package:acresapp/widgets/universal_widgets/show_loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class ScanMachineFundProvider with ChangeNotifier {
  BlueToothServiceProvider get blueToothService =>
      GetIt.instance<BlueToothServiceProvider>();
  DeviceService get deviceService => GetIt.instance<DeviceService>();

  void getNearestDevice(BuildContext context) {
    blueToothService.getNearestDeviceSerialNumber().then((String sasSerialNumber) {
      //todo delete this line. This is a hardcoded serial number used for testing
     // sasSerialNumber = '882279';
      final TimerProvider timerProvider = Provider.of<TimerProvider>(context, listen: false);
      timerProvider.resetTimer();
      if (sasSerialNumber.contains('table')) {
        _navigateToFundTablePage(context, sasSerialNumber);
      } else {
        _navigateToTransferPage(context, sasSerialNumber);
      }
      timerProvider.decrementSeconds();
    }).catchError((void sasSerialNumber) {
      Future.delayed(const Duration(milliseconds: 7000), () {
        showAlertPopUp(context, 'Error Occurred', 'Signal strength too weak. Try again');
        Navigator.pop(context);
      });
    });
  }

  void _navigateToTransferPage(BuildContext context, String serialNumber) async {
    showLoadingDialog(context);
    DeviceModel? result = await deviceService.getDevice(context, serialNumber);
    //popping loading dialog
    Navigator.pop(context);
    if (result != null) {
      //popping the scan machine screen
      Navigator.pop(context);
      Navigator.push<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => FundSlotsTransferScreen(result)),
      );
    } else {
      Navigator.pop(context);
      showAlertPopUp(context, 'An Error Occurred', 'Please try again');
    }
  }

  void _navigateToFundTablePage(BuildContext context, String serialNumber) async {
    showLoadingDialog(context);
    DeviceModel? result = await deviceService.getDevice(context, serialNumber);
    //popping loading dialog
    Navigator.pop(context);
    if (result != null) {
      //popping the scan machine screen
      Navigator.pop(context);
      Navigator.push<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => FundTableTransferScreen(serialNumber)),
      );
    } else {
      Navigator.pop(context);
      showAlertPopUp(context, 'An Error Occurred', 'Please try again');
    }
  }
}