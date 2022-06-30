import 'package:acresapp/screens/cash_out_table_screens/transfer_complete_cash_out_tables_screen.dart';
import 'package:acresapp/services/bluetooth_service.dart';
import 'package:acresapp/services/tables_slot_service.dart';
import 'package:acresapp/widgets/universal_widgets/alert_pop_up.dart';
import 'package:acresapp/widgets/universal_widgets/show_loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'cash_out_table_confirmation_screen.dart';

class CashOutTableProvider with ChangeNotifier {
  TablesSlotService get tablesService => GetIt.instance<TablesSlotService>();
  BlueToothServiceProvider get blueToothService =>
      GetIt.instance<BlueToothServiceProvider>();
  
  void cashOutTable(BuildContext context, String serialNumber, int amount) async {
    showLoadingDialog(context);
    print(serialNumber);
    final dynamic requestResult = await tablesService.cashOutTable(context, serialNumber, amount);
    //popping loading dialog
    Navigator.pop(context);
    if (requestResult != null) {
      //popping current page
      Navigator.pop(context);
      Navigator.push<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
            builder: (BuildContext context) =>
                TransferCompleteCashOutTablesScreen(amount)),
      );    } else {
      showAlertPopUp(context, 'Error Occurred', 'Please try again');
    }
  }


  void c2cConnect(BuildContext context, String serialNumber, ) async {
    String transactionSerialNumberResult = '';
    int amountResult = -1;
    await blueToothService.c2cConnect(serialNumber,
            (val) {
      transactionSerialNumberResult = val;
          Navigator.pop(context);
          Navigator.push<dynamic>(context, MaterialPageRoute<dynamic>(builder: (context) => CashOutTablesConfirmationScreen(amountResult, transactionSerialNumberResult, serialNumber)));
        }, (val) async {
          print('2 $val');
          if (val == -1) {
            await blueToothService.c2cDisconnect(serialNumber);
            print('disconected');
            Navigator.pop(context);
          } else {
              amountResult = val;
          }

        }, (){
          print('3');
        }).then((value) async => await blueToothService.c2cRequestCashout(serialNumber));
  }
  
  void c2cCancelRequest(BuildContext context, String serialNumber) async {
    try {
      await blueToothService.c2cCancelRequest(
          serialNumber);
    } catch (e) {
      print("Exception is caught inside the you are connected screen");
    }
    print('cancelled');
    await blueToothService.c2cDisconnect(serialNumber);
    print('disconected');
    Navigator.pop(context);
  }

  void c2cDisconnect(String serialNumber) async {
    await blueToothService.c2cDisconnect(serialNumber);
  }
  
}