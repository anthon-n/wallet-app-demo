import 'dart:async';

import 'package:acresapp/common/loaded_data.dart';
import 'package:acresapp/services/tables_slot_service.dart';
import 'package:acresapp/services/wallet_service.dart';
import 'package:acresapp/widgets/universal_widgets/alert_pop_up.dart';
import 'package:acresapp/widgets/universal_widgets/show_loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class FundTableGameSelectProvider with ChangeNotifier {
  TablesSlotService get tablesService => GetIt.instance<TablesSlotService>();
  int expandedTileIndex = -1;
  WalletService get walletService => GetIt.instance<WalletService>();
  final StreamController<List<dynamic>> fundTablesController = StreamController<List<dynamic>>.broadcast();

  void fundTable(BuildContext context, String serialNumber, double amount, String type, VoidCallback onNavigate) async {
    showLoadingDialog(context);
    final dynamic requestResult = await tablesService.fundTable(context, serialNumber, amount, type);
    //popping loading dialog
    Navigator.pop(context);
    if (requestResult != null) {
      onNavigate();
    } else {
      //onNavigate();
      showAlertPopUp(context, 'Error Occurred', 'Please try again');
    }
  }


  void loadWallets(BuildContext context) async {
    LoadedDataProvider loadedDataProvider = Provider.of<LoadedDataProvider>(context, listen: false);
    walletService.getWallets(context).then((dynamic value) {
      loadedDataProvider.updateLoadedWallets(value as List<dynamic>);
      fundTablesController.add(value);
      return value;
    });
  }

  void expandListTile(int index) {
    if (index == expandedTileIndex) {
      expandedTileIndex = -1;
    } else {
      expandedTileIndex = index;
    }
    notifyListeners();
  }

  void clearExpandedTiles() {
    expandedTileIndex = -1;
    notifyListeners();
  }

}