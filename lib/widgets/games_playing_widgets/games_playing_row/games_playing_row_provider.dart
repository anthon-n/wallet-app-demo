import 'package:acresapp/models/game_model.dart';
import 'package:acresapp/screens/cash_out_slots_screens/select_screen/cash_out_slots_provider.dart';
import 'package:acresapp/screens/cash_out_slots_screens/transfer_complete_cash_out_slots.dart';
import 'package:acresapp/services/game_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class GamesPlayingRowProvider with ChangeNotifier {
  GameService get gameService => GetIt.instance<GameService>();

  void cashOutAllFunds(BuildContext context, {required GameModel gameModel}) async {
    CashOutSlotsProvider _cashOutSlotsProvider =
    Provider.of<CashOutSlotsProvider>(context, listen: false);
    _cashOutSlotsProvider
        .cashoutAllSlot(context, '${gameModel.device!.sasSerialNumber}', () {
      Navigator.pop(context);
      Navigator.push<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
            builder: (BuildContext context) =>
                TransferCompleteCashOutSlotsScreen(
                    amount: (gameModel.device!.currentCredits as int) /
                        100)),
      );
    });
  }

  void cashOutFunds(BuildContext context, {required String priceEditingControllerText, required GameModel gameModel}) async {
    CashOutSlotsProvider _cashOutSlotsProvider =
    Provider.of<CashOutSlotsProvider>(context, listen: false);
    double amount = 0;
    if (priceEditingControllerText != '') {
      amount = double.parse(priceEditingControllerText);
    }
    if (amount > 0) {
      _cashOutSlotsProvider.cashoutSlot(
          context, '${gameModel.device!.sasSerialNumber}', amount, () {
        Navigator.pop(context);
        Navigator.push<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
              builder: (BuildContext context) =>
                  TransferCompleteCashOutSlotsScreen(
                    amount: amount,
                  )),
        );
      });
    }
  }

}