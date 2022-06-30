import 'package:acresapp/screens/fund_table_screens/fund_table_wait_for_confirmation_screen.dart';
import 'package:acresapp/screens/fund_table_screens/transfer_complete_fund_tables_screen.dart';
import 'package:acresapp/services/bluetooth_service.dart';
import 'package:acresapp/services/tables_slot_service.dart';
import 'package:acresapp/widgets/universal_widgets/alert_pop_up.dart';
import 'package:acresapp/widgets/universal_widgets/show_loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class FundTableProvider with ChangeNotifier {
  TablesSlotService get tablesService => GetIt.instance<TablesSlotService>();
  BlueToothServiceProvider get blueToothService =>
      GetIt.instance<BlueToothServiceProvider>();

  void fundTable(BuildContext context, String serialNumber, double amount, String type, VoidCallback onNavigate) async {
    showLoadingDialog(context);
    print(serialNumber);
    final dynamic requestResult = await tablesService.fundTable(context, serialNumber, amount, type);
    //popping loading dialog
    Navigator.pop(context);
    if (requestResult != null) {
      onNavigate();
    } else {
      //popping current page
      Navigator.pop(context);
      showAlertPopUp(context, 'Error Occurred', 'Please try again');
    }
  }

  void transfer(BuildContext context,
      {required int chosenAmount,
        required String priceEditingControllerText,
        required String serialNumber}) {
    int amount = -1;
    if (chosenAmount == 0) {
      amount = 20;
    } else if (chosenAmount == 1) {
      amount = 50;
    } else if (chosenAmount == 2) {
      amount = int.parse(priceEditingControllerText);
    } else if (priceEditingControllerText != '') {
      amount = int.parse(priceEditingControllerText);
    }
    if (amount > 0) {
      //popping current page
      Navigator.pop(context);
      print('amount: $amount');
      Navigator.push<dynamic>(context, MaterialPageRoute<dynamic>(builder: (context) => FundTableWaitForConfirmationScreen(serialNumber, amount, '0')));
    }
  }



  Future<void> c2cConnectFunction(BuildContext context, {required String serialNumber, required String type, required int amt}) async {
    await blueToothService.c2cConnect(serialNumber, (val) {
      fundTable(
          context, val, amt.toDouble(), type, () {
        //popping current page
        Navigator.pop(context);
        Navigator.push<dynamic>(context, MaterialPageRoute<dynamic>(builder: (context) => TransferCompleteFundTablesScreen()));
      });
    }, (val) {
      if (val == -1) {
        c2cDisconnect(serialNumber);
        Navigator.pop(context);
      }
    }, (){
    }).then((value) async {
      print('buying in 1');
      await blueToothService.c2cRequestBuyin(serialNumber, amt);
    });

  }

  void c2cDisconnect(String serialNumber) async {
    await blueToothService.c2cDisconnect(serialNumber);
  }

}