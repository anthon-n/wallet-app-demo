import 'dart:async';

import 'package:acresapp/common/loaded_data.dart';
import 'package:acresapp/services/wallet_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class HomeWalletItemsProvider with ChangeNotifier {
  WalletService get walletService => GetIt.instance<WalletService>();
  final StreamController<List<dynamic>> fundSlotsController = StreamController<List<dynamic>>.broadcast();


  void loadWallets(BuildContext context) async {
    LoadedDataProvider loadedDataProvider = Provider.of<LoadedDataProvider>(context, listen: false);
    walletService.getWallets(context).then((dynamic value) {
      loadedDataProvider.updateLoadedWallets(value as List<dynamic>);
      fundSlotsController.add(value);
      return value;
    });
  }
}