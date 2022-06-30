import 'package:flutter/cupertino.dart';

class NamesProvider with ChangeNotifier {
  String userName;
  String hostName;

  NamesProvider(this.userName, this.hostName);

  void changeName(String newName) {
    userName = newName;
    notifyListeners();
  }
  void changeHostName(String newName) {
    hostName = newName;
    notifyListeners();
  }
}