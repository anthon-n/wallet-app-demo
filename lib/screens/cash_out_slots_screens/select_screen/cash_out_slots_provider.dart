import 'dart:async';

import 'package:acresapp/common/loaded_data.dart';
import 'package:acresapp/services/game_service.dart';
import 'package:acresapp/widgets/universal_widgets/alert_pop_up.dart';
import 'package:acresapp/widgets/universal_widgets/show_loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class CashOutSlotsProvider with ChangeNotifier {
  GameService get gameService => GetIt.instance<GameService>();
  StreamController<Map<String, dynamic>> cashOutSlotsController = StreamController<Map<String, dynamic>>.broadcast();
  GameService get sessionService => GetIt.instance<GameService>();

  List<Widget> newRowItems = <Widget>[];
  List<Widget>? loadedRowItems;

  int expandedTileIndex = -1;

  void cashoutSlot(BuildContext context, String serialNumber, double amount, VoidCallback onNavigate) async {
    showLoadingDialog(context);
    final dynamic requestResult = await gameService.cashOutGame(context, serialNumber, amount,);
    //popping loading dialog
    Navigator.pop(context);
    if (requestResult == 0) {
      clearExpandedTiles();
      onNavigate();
    } else {
      showAlertPopUp(context, 'Error Occurred', 'Please try again');
    }
  }

  void cashoutAllSlot(BuildContext context, String serialNumber, VoidCallback onNavigate) async {
    showLoadingDialog(context);
    final dynamic requestResult = await gameService.cashOutAllGameAmt(context, serialNumber);
    //popping loading dialog
    Navigator.pop(context);
    if (requestResult == 0) {
      clearExpandedTiles();
      onNavigate();
    } else {
      showAlertPopUp(context, 'Error Occurred', 'Please try again');
    }
  }


  void expandListTile(int index) {
    if (index == expandedTileIndex) {
      expandedTileIndex = -1;
    } else {
      expandedTileIndex = index;
    }
    notifyListeners();
  }



  void loadGames(BuildContext context) {
    final LoadedDataProvider loadedDataProvider = Provider.of<LoadedDataProvider>(context, listen: false);
      sessionService.getGames(context).then((value) {
        loadedDataProvider.updateLoadedGames(value as Map<String, dynamic>);
        cashOutSlotsController.sink.add(value);
        return value;
      });
  }

  void clearExpandedTiles() {
    expandedTileIndex = -1;
    notifyListeners();
  }
}
