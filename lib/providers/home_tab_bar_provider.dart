import 'package:acresapp/screens/cash_out_slots_screens/select_screen/cash_out_slots_view.dart';
import 'package:acresapp/screens/home/home_game_items/home_game_items.dart';
import 'package:acresapp/screens/home/home_wallet_items/home_wallet_items.dart';
import 'package:flutter/cupertino.dart';

class HomeTabBarProvider with ChangeNotifier {
  Widget? widgetsToDisplay;
  int? tabDisplayed;

  void displayHomeWalletItems() {
    widgetsToDisplay = HomeWalletItems();
    tabDisplayed = 0;
    notifyListeners();

  }

  void displayHomeGameItems() {
    widgetsToDisplay = HomeGameItems();
    tabDisplayed = 1;
    notifyListeners();
  }
}