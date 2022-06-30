import 'package:acresapp/screens/home/home.screen.dart';
import 'package:acresapp/screens/home/home_tab_bar_view.dart';
import 'package:acresapp/screens/main_tab_view_cash_out_fund_slots.dart';
import 'package:flutter/cupertino.dart';

class HomePageProvider with ChangeNotifier {
  Widget widgetsToDisplay;
  String pageDisplayedName;
  HomePageProvider(this.widgetsToDisplay, this.pageDisplayedName);

  void displayTapometerView() {
    widgetsToDisplay = HomeScreen();
    pageDisplayedName = "HOME";
    notifyListeners();
  }
  void displayTabView() {
      widgetsToDisplay = HomeTabBarView();
      pageDisplayedName = "TABVIEW";
      notifyListeners();
  }
}