import 'package:acresapp/models/wallet_model.dart';
import 'package:acresapp/providers/tab_view_cash_out_fund_slots_provider.dart';
import 'package:acresapp/providers/timer_provider.dart';
import 'package:acresapp/screens/fund_slots_screens/select_screen/fund_slots_provider.dart';
import 'package:acresapp/screens/fund_slots_screens/transfer_complete_fund_slots_screen.dart';
import 'package:acresapp/screens/transfer_complete_convert_points.dart';
import 'package:acresapp/services/wallet_service.dart';
import 'package:acresapp/widgets/universal_widgets/alert_pop_up.dart';
import 'package:acresapp/widgets/universal_widgets/show_loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class WalletRowProvider with ChangeNotifier {
  WalletService get walletService => GetIt.instance<WalletService>();
  int selectedAmount = -1;
  void changeSelectedAmount(int newAmount) {
    if (selectedAmount == newAmount) selectedAmount = -1;
    else selectedAmount = newAmount;
    notifyListeners();
  }
  void transferDollars(BuildContext context, {required String priceEditingControllerText, required WalletModel walletModel}) {
    FundSlotsProvider _fundSlotsProvider =
        Provider.of<FundSlotsProvider>(context, listen: false);
    TabViewCashOutFundSlotsProvider _tabViewCashOutFundSlotsProvider =
        Provider.of<TabViewCashOutFundSlotsProvider>(context, listen: false);
    TimerProvider timerProvider =
        Provider.of<TimerProvider>(context, listen: false);
    timerProvider.resetTimer();
    
    _fundSlotsProvider.clearExpandedTiles();
    double amount = 0;
    if (selectedAmount == 0) {
      amount = 20;
    } else if (selectedAmount == 1) {
      amount = 50;
    } else if (selectedAmount == 2) {
      amount = double.parse(
          '${walletModel.balance! / 100}');
    } else if (priceEditingControllerText !=
        '') {
      amount = double.parse(
          priceEditingControllerText);
    }
    _fundSlotsProvider.fundSlot(
        context,
        '${_tabViewCashOutFundSlotsProvider.deviceModel!.sasSerialNumber}',
        amount,
        walletModel.type.toString(), () {
     
      //popping current page
      Navigator.pop(context);
      Navigator.push<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
            builder: (BuildContext context) =>
                TransferCompleteFundSlotsScreen(
                  amount: amount,
                )),
      );
    });
  }

  void transferPoints(BuildContext context, {required String pointsEditingControllerText, required WalletModel walletModel}) async {
    FundSlotsProvider _fundSlotsProvider =
    Provider.of<FundSlotsProvider>(context, listen: false);

    int selectedPointsAmount = int.parse(
        pointsEditingControllerText);
    int pointsAmount = 0;
    if (selectedAmount == 0) {
      pointsAmount = 20;
    } else if (selectedAmount == 1) {
      pointsAmount =
      walletModel.balance as int;
    } else {
      pointsAmount = int.parse(
          pointsEditingControllerText);
    }
    showLoadingDialog(context);
    dynamic result = await walletService
        .redeemPointsToFreePlay(
        context, pointsAmount);
    //popping loading dialog
    Navigator.pop(context);
    if (result == 0) {
      _fundSlotsProvider.clearExpandedTiles();
      //popping current page
      Navigator.pop(context);
      Navigator.push<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
              builder: (BuildContext context) =>
                  TransferCompleteConvertPointsScreen(
                      amount: int.parse(
                          pointsEditingControllerText))));
    } else {
      showAlertPopUp(context, 'Error Occurred',
          'Try again');
    }
  }

  void scrollToFocusedElement(ScrollController scrollController, GlobalKey itemKey) {
    scrollController.position.ensureVisible(
      itemKey.currentContext!.findRenderObject() as RenderObject,
      alignment: 0.3,
      duration: const Duration(milliseconds: 500),
    );
  }

}