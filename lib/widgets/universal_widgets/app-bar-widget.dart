import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/app-icons.dart';
import 'package:acresapp/common/helpers/app-images.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:acresapp/providers/home_page_provider.dart';
import 'package:acresapp/screens/cash_out_table_screens/cash_out_table_screen_you_are_connected.dart';
import 'package:acresapp/screens/fund_table_screens/fund_table_transfer/fund_table_transfer_screen.dart';
import 'package:acresapp/screens/settings_screen/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatelessWidget {
  bool isMenuNeeded;
  bool isClickable;
  AppBarWidget({this.isMenuNeeded = true, this.isClickable = false});

  @override
  Widget build(BuildContext context) {
    HomePageProvider _homePageProvider = Provider.of<HomePageProvider>(context, listen: false);
    return Container(
        height: SizeBlock.v! * 100,
        padding: EdgeInsets.only(top: SizeBlock.v! * 30, bottom:  SizeBlock.v! * 20, left:  SizeBlock.v! * 20, right: SizeBlock.v! * 20),
        child: Center(
          child: Row(children: <Widget>[
            isMenuNeeded ? GestureDetector(
              onTap: () {
                Navigator.push<dynamic>(context, MaterialPageRoute<dynamic>(builder: (context) => SettingsScreen()));
              },
                child: SvgPicture.asset(AppIcons.menu)) : GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child:  Icon(Icons.arrow_back, color: AppColors.white, size: SizeBlock.v! * 35,),),
            const Spacer(),
            GestureDetector(
              onTap: () {
                  if (isClickable) {
                    _homePageProvider.displayTapometerView();
                  }
                },
                child: Image.asset(AppIcons.logo, width: SizeBlock.h! * 142,)),
            const Spacer(),
            GestureDetector(
              onTap: () {
                if (isClickable) {
                  //Navigator.push<dynamic>(context, MaterialPageRoute<dynamic>(builder: (context) => CashOutTableYouAreConnectedScreen()));
                }
              },
              child: Container(
                  width: SizeBlock.v! * 45,
                  height: SizeBlock.v! * 45,
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(SizeBlock.v!  * 100),
                    border: Border.all(width: SizeBlock.v! * 3, color: Colors.white),
                  ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(SizeBlock.v! * 100),
                  child: const Image(
                    image: AssetImage(AppImages.avatar),
                    alignment: Alignment.center,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            )
          ]),
        ));
  }
}
// image: AssetImage('assets/images/avatar.png'),