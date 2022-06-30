import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/app-images.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:acresapp/models/device_model.dart';
import 'package:acresapp/providers/tab_view_cash_out_fund_slots_provider.dart';
import 'package:acresapp/widgets/universal_widgets/app-bar-widget.dart';
import 'package:acresapp/widgets/universal_widgets/wallet-games.widget.dart';
import 'package:acresapp/widgets/wallet_widgets/wallet_row/wallet_row_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MainTabViewCashOutFundSlots extends StatefulWidget {
  DeviceModel deviceModel;
  MainTabViewCashOutFundSlots(this.deviceModel);
  @override
  _MainTabViewCashOutFundSlotsState createState() =>
      _MainTabViewCashOutFundSlotsState();
}

class _MainTabViewCashOutFundSlotsState extends State<MainTabViewCashOutFundSlots> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          reverse: true,
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -SizeBlock.v! * 450,
                  bottom: SizeBlock.v! * 360,
                  child: SvgPicture.asset(
                    AppImages.backgroundHome,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
                ),
                Column(
                  children: <Widget>[
                    AppBarWidget(),
                    SizedBox(height: SizeBlock.v! * 34),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        WalletGamesWidget(),
                      ],
                    ),
                    SizedBox(height: SizeBlock.v! * 25),
                    Expanded(child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: SizeBlock.h! * 20,),
                      child: Consumer<TabViewCashOutFundSlotsProvider>(
                        builder: (BuildContext context,
                            TabViewCashOutFundSlotsProvider
                                _tabViewCashOutFundSlotsProvider,
                            Widget? child) {
                          return _tabViewCashOutFundSlotsProvider.widgetsToDisplay!;
                        },
                      ),
                    )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
