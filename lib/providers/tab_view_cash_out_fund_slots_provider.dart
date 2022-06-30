import 'package:acresapp/models/device_model.dart';
import 'package:acresapp/screens/cash_out_slots_screens/select_screen/cash_out_slots_view.dart';
import 'package:acresapp/screens/fund_slots_screens/select_screen/fund_slots_view.dart';
import 'package:flutter/cupertino.dart';

class TabViewCashOutFundSlotsProvider with ChangeNotifier {
  Widget? widgetsToDisplay;
  int? tabDisplayed;
  DeviceModel? deviceModel;
  void displayFundSlotsView() {
    widgetsToDisplay = FundSlotsView(deviceModel!);
    tabDisplayed = 0;
    notifyListeners();
  }

  void displayCashOutSlotsView() {
    widgetsToDisplay = CashOutSlotsView(deviceModel!);
    tabDisplayed = 1;
    notifyListeners();
  }

}