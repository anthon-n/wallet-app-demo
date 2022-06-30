import 'dart:async';

import 'package:acresapp/common/loaded_data.dart';
import 'package:acresapp/services/game_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class HomeGameItemsProvider with ChangeNotifier {
  StreamController<Map<String, dynamic>> cashOutSlotsController =
  StreamController<Map<String, dynamic>>.broadcast();
  GameService get sessionService => GetIt.instance<GameService>();

  void loadGames(BuildContext context) async {
    LoadedDataProvider loadedDataProvider = Provider.of<LoadedDataProvider>(context, listen: false);
    sessionService.getGames(context).then((value) {
      loadedDataProvider.updateLoadedGames(value as Map<String, dynamic>);
      cashOutSlotsController.add(value);
      return value;
    });
  }

}