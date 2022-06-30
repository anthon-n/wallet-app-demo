import 'package:flutter/cupertino.dart';

class LoadedDataProvider with ChangeNotifier {
  Map<String, dynamic> loadedGames = Map<String, dynamic>();
  List<dynamic> loadedWallets = <dynamic>[];

  void updateLoadedGames(Map<String, dynamic> newLoadedGames) {
    loadedGames = newLoadedGames;
    notifyListeners();
  }

  void updateLoadedWallets(List<dynamic> newLoadedWallets) {
    loadedWallets = newLoadedWallets;
    notifyListeners();
  }
}






