import 'package:flutter/cupertino.dart';

class FundTableTransferProvider with ChangeNotifier {
  int selectedAmount = -1;
  void changeSelectedAmount(int newAmount) {
    if (selectedAmount == newAmount) selectedAmount = -1;
    else selectedAmount = newAmount;
    notifyListeners();
  }
}