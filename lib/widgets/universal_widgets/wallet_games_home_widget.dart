import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:acresapp/providers/home_tab_bar_provider.dart';
import 'package:acresapp/providers/tab_view_cash_out_fund_slots_provider.dart';
import 'package:acresapp/screens/cash_out_slots_screens/select_screen/cash_out_slots_provider.dart';
import 'package:acresapp/screens/fund_slots_screens/select_screen/fund_slots_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletGamesHomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FundSlotsProvider _fundSlotsProvider =
    Provider.of<FundSlotsProvider>(context, listen: false);
    final CashOutSlotsProvider _cashOutSlotsProvider =
    Provider.of<CashOutSlotsProvider>(context, listen: false);

    final HomeTabBarProvider _homeTabBarProvider =
    Provider.of<HomeTabBarProvider>(context, listen: false);

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
            Consumer<HomeTabBarProvider>(
              builder: (BuildContext context,
                  HomeTabBarProvider
                  _homeTabBarProvider,
                  Widget? child) {
                return GestureDetector(
                  onTap: () {
                    if (_homeTabBarProvider.tabDisplayed == 1) {
                      _homeTabBarProvider.displayHomeWalletItems();
                      _cashOutSlotsProvider.clearExpandedTiles();
                    }
                  },
                  child: Container(
                    width: SizeBlock.h! * 108,
                    //padding: EdgeInsets.symmetric(vertical: SizeBlock.v! * 5, horizontal: SizeBlock.v! * 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient:
                        (_homeTabBarProvider.tabDisplayed == 0)
                            ? AppColors.tabBarRedGradient
                            : AppColors.tabBarNoColor),
                    child: Center(
                      child: Text(
                        'WALLET',
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: (_homeTabBarProvider
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
                _homeTabBarProvider.displayHomeGameItems();
              },
              child: Consumer<HomeTabBarProvider>(
                builder: (BuildContext context,
                    HomeTabBarProvider
                    _homeTabBarProvider,
                    Widget? child) {
                  return GestureDetector(
                    onTap: () {
                      if (_homeTabBarProvider.tabDisplayed == 0) {
                        _homeTabBarProvider
                            .displayHomeGameItems();
                        _fundSlotsProvider.clearExpandedTiles();
                      }
                    },
                    child: Container(
                      width: SizeBlock.h! * 108,
                      //padding: EdgeInsets.symmetric(vertical: SizeBlock.v! * 5, horizontal: SizeBlock.v! * 15),
                      decoration: BoxDecoration(
                          gradient:
                          (_homeTabBarProvider.tabDisplayed ==
                              1)
                              ? AppColors.tabBarRedGradient
                              : AppColors.tabBarNoColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: Text(
                          'GAMES',
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color: (_homeTabBarProvider
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
