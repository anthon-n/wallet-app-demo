import 'package:acresapp/screens/fund_table_screens/fund_table_wait_for_confirmation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FundTableRowProvider with ChangeNotifier {
  int selectedAmount = -1;
  void changeSelectedAmount(int newAmount) {
    if (selectedAmount == newAmount) selectedAmount = -1;
    else selectedAmount = newAmount;
    notifyListeners();
  }
  void transfer(BuildContext context, {required String priceEditingControllerText, required String serialNumber, required String type}) {
    double amount = 0;
    if (selectedAmount == 0) {
      amount = 20;
    } else if (selectedAmount == 1) {
      amount = 50;
    } else if (selectedAmount == 2) {
      amount = 100;
    } else if (priceEditingControllerText != '') {
      amount = double.parse(priceEditingControllerText);
    }
    if (amount > 0) {

      Navigator.pop(context);
      Navigator.push<dynamic>(context, MaterialPageRoute<dynamic>(builder: (BuildContext context) => FundTableWaitForConfirmationScreen(serialNumber, amount.toInt(), type)));
    }
  }

}