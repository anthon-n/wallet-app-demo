import 'package:acresapp/models/device_model.dart';
import 'package:acresapp/providers/tab_view_cash_out_fund_slots_provider.dart';
import 'package:acresapp/providers/timer_provider.dart';
import 'package:acresapp/screens/cash_out_table_screens/cash_out_table_screen_you_are_connected.dart';
import 'package:acresapp/services/bluetooth_service.dart';
import 'package:acresapp/services/device_service.dart';
import 'package:acresapp/widgets/universal_widgets/alert_pop_up.dart';
import 'package:acresapp/widgets/universal_widgets/show_loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../main_tab_view_cash_out_fund_slots.dart';

class ScanMachineCashOutProvider with ChangeNotifier {
  BlueToothServiceProvider get blueToothService =>
      GetIt.instance<BlueToothServiceProvider>();
  DeviceService get deviceService => GetIt.instance<DeviceService>();


  void getNearestDeviceSerialNumber(BuildContext context) {
    blueToothService.getNearestDeviceSerialNumber().then((String sasSerialNumber) {
      //todo delete this line. This is a hardcoded serial number used for testing
    //  sasSerialNumber = '882279';
      final TimerProvider timerProvider = Provider.of<TimerProvider>(context, listen: false);
      timerProvider.resetTimer();
      if (sasSerialNumber.contains('table')) {
        _navigateToCashoutTablePage(context, sasSerialNumber);
      } else {
        _navigateToTransferSlotPage(context, sasSerialNumber);
      }
      timerProvider.decrementSeconds();
    }).catchError((void sasSerialNumber) {
      Future.delayed(const Duration(milliseconds: 7000), () {
        showAlertPopUp(context, 'Error Occurred', 'Signal strength too weak. Try again');
        Navigator.pop(context);
      });
    });
  }

  void _navigateToTransferSlotPage(BuildContext context, String serialNumber) async {
    showLoadingDialog(context);
    DeviceModel? result = await deviceService.getDevice(context, serialNumber);
    //popping loading dialog
    Navigator.pop(context);
    if (result != null) {
      TabViewCashOutFundSlotsProvider _tabViewCashOutFundSlotsProvider = Provider.of<TabViewCashOutFundSlotsProvider>(context, listen: false);
      _tabViewCashOutFundSlotsProvider.deviceModel = result;
      _tabViewCashOutFundSlotsProvider.displayCashOutSlotsView();
      //popping the scan machine screen
      Navigator.pop(context);
      Navigator.push<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => MainTabViewCashOutFundSlots(result)),
      );
    } else {
      Navigator.pop(context);
      showAlertPopUp(context, 'An Error Occurred', 'Please try again');
    }
  }

  void _navigateToCashoutTablePage(BuildContext context, String serialNumber) async {
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
            builder: (BuildContext context) => CashOutTableYouAreConnectedScreen(serialNumber)),
      );
    } else {
      Navigator.pop(context);
      showAlertPopUp(context, 'An Error Occurred', 'Please try again');
    }
  }

}