import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:acresapp/providers/tab_view_cash_out_fund_slots_provider.dart';
import 'package:acresapp/screens/cash_out_slots_screens/select_screen/cash_out_slots_provider.dart';
import 'package:acresapp/screens/fund_slots_screens/select_screen/fund_slots_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletGamesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FundSlotsProvider _fundSlotsProvider =
        Provider.of<FundSlotsProvider>(context, listen: false);
    final CashOutSlotsProvider _cashOutSlotsProvider =
        Provider.of<CashOutSlotsProvider>(context, listen: false);

    final TabViewCashOutFundSlotsProvider _tabViewCashOutFundSlotsProvider =
        Provider.of<TabViewCashOutFundSlotsProvider>(context, listen: false);
    return Container(
        padding: EdgeInsets.symmetric(
            vertical: SizeBlock.v! * 3, horizontal: SizeBlock.v! * 3),
        height: SizeBlock.v! * 43,
        //width: SizeBlock.h! * 222,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: AppColors.tabBarNoColor,
            borderRadius: BorderRadius.circular(SizeBlock.v! * 30)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Consumer<TabViewCashOutFundSlotsProvider>(
              builder: (BuildContext context,
                  TabViewCashOutFundSlotsProvider
                      _tabViewCashOutFundSlotsProvider,
                  Widget? child) {
                return GestureDetector(
                  onTap: () {
                    if (_tabViewCashOutFundSlotsProvider.tabDisplayed == 1) {
                      _tabViewCashOutFundSlotsProvider.displayFundSlotsView();
                      _cashOutSlotsProvider.clearExpandedTiles();
                    }
                  },
                  child: Container(
                    width: SizeBlock.h! * 108,
                    //padding: EdgeInsets.symmetric(vertical: SizeBlock.v! * 5, horizontal: SizeBlock.v! * 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient:
                            (_tabViewCashOutFundSlotsProvider.tabDisplayed == 0)
                                ? AppColors.tabBarRedGradient
                                : AppColors.tabBarNoColor),
                    child: Center(
                      child: Text(
                        'WALLET',
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: (_tabViewCashOutFundSlotsProvider
                                        .tabDisplayed ==
                                    0)
                                ? AppColors.white
                                : AppColors.grey,
                            fontFamily: 'MostraNuova',
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                );
              },
            ),
            //SizedBox(width: SizeBlock.v! * 15),
            GestureDetector(
              onTap: () {
                _fundSlotsProvider.clearExpandedTiles();
                _tabViewCashOutFundSlotsProvider.displayCashOutSlotsView();
              },
              child: Consumer<TabViewCashOutFundSlotsProvider>(
                builder: (BuildContext context,
                    TabViewCashOutFundSlotsProvider
                        _tabViewCashOutFundSlotsProvider,
                    Widget? child) {
                  return GestureDetector(
                    onTap: () {
                      if (_tabViewCashOutFundSlotsProvider.tabDisplayed == 0) {
                        _tabViewCashOutFundSlotsProvider
                            .displayCashOutSlotsView();
                        _fundSlotsProvider.clearExpandedTiles();
                      }
                    },
                    child: Container(
                      width: SizeBlock.h! * 108,
                      //padding: EdgeInsets.symmetric(vertical: SizeBlock.v! * 5, horizontal: SizeBlock.v! * 15),
                      decoration: BoxDecoration(
                          gradient:
                              (_tabViewCashOutFundSlotsProvider.tabDisplayed ==
                                      1)
                                  ? AppColors.tabBarRedGradient
                                  : AppColors.tabBarNoColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: Text(
                          'GAMES',
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color: (_tabViewCashOutFundSlotsProvider
                                          .tabDisplayed ==
                                      1)
                                  ? AppColors.white
                                  : AppColors.grey,
                              fontFamily: 'MostraNuova',
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            //const SizedBox(width: 15),
          ],
        ));
  }
}
