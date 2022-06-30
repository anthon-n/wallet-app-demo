import 'dart:async';
import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/app-icons.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:acresapp/common/loaded_data.dart';
import 'package:acresapp/providers/home_page_provider.dart';
import 'package:acresapp/providers/home_tab_bar_provider.dart';
import 'package:acresapp/services/wallet_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget();

  @override
  _BottomNavigationBarWidgetState createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {


  WalletService get walletService => GetIt.instance<WalletService>();

  StreamController<List<dynamic>> _walletAmountConntroller = StreamController();

  Timer? _timer;

  void loadWallets(BuildContext context) async {
    LoadedDataProvider loadedDataProvider = Provider.of<LoadedDataProvider>(context, listen: false);
    walletService.getWallets(context).then((dynamic value) {
      loadedDataProvider.updateLoadedWallets(value as List<dynamic>);
      _walletAmountConntroller.add(value);
      return value;
    });
  }

  @override
  void initState() {
    loadWallets(context);
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (_) => loadWallets(context));
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LoadedDataProvider loadedDataProvider = Provider.of<LoadedDataProvider>(context, listen: false);
    return Container(
        height: SizeBlock.v! * 88,
        padding:  EdgeInsets.symmetric(
          vertical: 5,
          horizontal: SizeBlock.h! * 10,
        ),
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(children: <Widget>[
          Divider(
            height: 1,
            color: Colors.black.withOpacity(0.4),
          ),
          SizedBox(height: SizeBlock.v! * 10),
          Stack(
            children: <Widget>[
              Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                    Container(
                        width: SizeBlock.h! * 210,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                width: SizeBlock.h! * 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  final HomeTabBarProvider _homeTabBarProvider = Provider.of<HomeTabBarProvider>(context, listen: false);
                                  final HomePageProvider _homePageProvider = Provider.of<HomePageProvider>(context, listen: false);
                                  _homeTabBarProvider.displayHomeGameItems();
                                  _homePageProvider.displayTabView();
                                  },
                                  child: buildIconWithTextVertical(AppIcons.game, 'Games')),
                              SizedBox(
                                width: SizeBlock.h! * 10,
                              ),
                              Container(
                                child: buildIconWithTextVertical(
                                    AppIcons.profile, 'Profile'),
                              ),
                              SizedBox(
                                width: SizeBlock.h! * 10,
                              ),
                              buildIconWithTextVertical(
                                  AppIcons.empty_icon, 'Cash In/Out'),
                            ])),
                    GestureDetector(
                      onTap: () {
                        final HomeTabBarProvider _homeTabBarProvider = Provider.of<HomeTabBarProvider>(context, listen: false);
                        final HomePageProvider _homePageProvider = Provider.of<HomePageProvider>(context, listen: false);
                        _homeTabBarProvider.displayHomeWalletItems();
                        _homePageProvider.displayTabView();
                        //Navigator.push<dynamic>(context, MaterialPageRoute<dynamic>(builder: (BuildContext context) => MainTabViewCashOutFundSlots()));
                      },
                      child: Container(
                          width: SizeBlock.h! * 136,
                          height: SizeBlock.v! * 44,
                          decoration: BoxDecoration(
                              color: AppColors.lightGrey,
                              borderRadius:
                                  BorderRadius.circular(SizeBlock.v! * 10)),
                          padding: EdgeInsets.symmetric(
                              vertical: SizeBlock.v! * 4,
                              horizontal: SizeBlock.v! * 12),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                buildIconWithTextVertical(
                                    AppIcons.wallet, 'Wallet'),
                                const Spacer(),
                                RichText(
                                  text: TextSpan(
                                    children: <InlineSpan>[
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.top,
                                        baseline: TextBaseline.alphabetic,
                                        child: Transform.translate(
                                          offset: const Offset(0.0, 2.0),
                                          child: Text('\$',
                                              style: TextStyle(
                                                  fontFamily: 'KorolevCompressed',
                                                  decoration: TextDecoration.none,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: SizeBlock.v! * 15)),
                                        ),
                                      ),
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.top,
                                        baseline: TextBaseline.alphabetic,
                                        child: Transform.translate(
                                          offset: const Offset(0.0, 0.0),
                                          child: StreamBuilder<Object>(
                                            stream: _walletAmountConntroller.stream,
                                            initialData: loadedDataProvider.loadedWallets,
                                            builder: (context, streamBuilderSnapshot) {
                                              if (!streamBuilderSnapshot.hasData) {
                                                return Text('',
                                                    style: TextStyle(
                                                        fontFamily: 'KorolevCompressed',
                                                        decoration: TextDecoration.none,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: SizeBlock.v! * 24));
                                              } else if (streamBuilderSnapshot.hasData && !streamBuilderSnapshot.hasError && loadedDataProvider.loadedWallets.isNotEmpty) {
                                                //print(streamBuilderSnapshot.data);
                                                try {
                                                    return Text(
                                                        '${((streamBuilderSnapshot.data! as List).elementAt(0)['balance'] / 100).toStringAsFixed(2)}',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'KorolevCompressed',
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize:
                                                                SizeBlock.v! *
                                                                    24));
                                                  } catch(e) {
                                                  return Text(
                                                      '',
                                                      style: TextStyle(
                                                          fontFamily:
                                                          'KorolevCompressed',
                                                          decoration:
                                                          TextDecoration
                                                              .none,
                                                          color: Colors.black,
                                                          fontWeight:
                                                          FontWeight.w700,
                                                          fontSize:
                                                          SizeBlock.v! *
                                                              24));
                                                  }
                                                } else {
                                                return Text('',
                                                    style: TextStyle(
                                                        fontFamily: 'KorolevCompressed',
                                                        decoration: TextDecoration.none,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: SizeBlock.v! * 24));
                                              }
                                            }
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ])),
                    ),
                  ])),
            ],
          )
        ]));
  }
}

Widget buildIconWithTextVertical(String asset, String title) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: SizeBlock.v! * 20,
          width: SizeBlock.v! * 20,
          child: SvgPicture.asset(
            asset,
            height: SizeBlock.v! * 20,
            width: SizeBlock.v! * 20,
          ),
        ),
        SizedBox(height: SizeBlock.v! * 3),
        (asset == AppIcons.empty_icon)
            ? Text(title,
                style: TextStyle(
                    height: SizeBlock.v! * 1.85,
                    fontFamily: 'Korolev',
                    decoration: TextDecoration.none,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: SizeBlock.v! * 10))
            : Text(title,
                style: TextStyle(
                    fontFamily: 'Korolev',
                    decoration: TextDecoration.none,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: SizeBlock.v! * 10))
      ]);
}
