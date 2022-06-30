import 'package:acresapp/common/helpers/size_block.dart';
import 'package:acresapp/providers/home_tab_bar_provider.dart';
import 'package:acresapp/screens/home/home_game_items/home_game_items_provider.dart';
import 'package:acresapp/screens/home/home_wallet_items/home_wallet_items_provider.dart';
import 'package:acresapp/widgets/universal_widgets/wallet_games_home_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTabBarView extends StatefulWidget {
  @override
  _HomeTabBarViewState createState() =>
      _HomeTabBarViewState();
}

class _HomeTabBarViewState extends State<HomeTabBarView> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeWalletItemsProvider>(
          create: (BuildContext context) => HomeWalletItemsProvider(),
        ),
        ChangeNotifierProvider<HomeGameItemsProvider>(
          create: (BuildContext context) => HomeGameItemsProvider(),
        ),
      ],
      child: Column(
        children: <Widget>[
          SizedBox(height: SizeBlock.v! * 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              WalletGamesHomeWidget(),
            ],
          ),
          SizedBox(height: SizeBlock.v! * 25),
          Expanded(child: Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeBlock.h! * 30,),
            child: Consumer<HomeTabBarProvider>(
              builder: (BuildContext context,
                  HomeTabBarProvider
                  _homeTabBarProvider,
                  Widget? child) {
                return _homeTabBarProvider.widgetsToDisplay!;
              },
            ),
          )),
        ],
      ),
    );
  }
}
