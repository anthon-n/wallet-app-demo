import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/app-icons.dart';
import 'package:acresapp/common/helpers/app-images.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:acresapp/widgets/universal_widgets/app-bar-widget.dart';
import 'package:acresapp/widgets/universal_widgets/bottom-navigation-bar.widget.dart';
import 'package:acresapp/widgets/pop_up_view_widgets/pop_up_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WrapperAllScreenWidget extends StatelessWidget {
  const WrapperAllScreenWidget(this.child, {this.isHomeScreen = false});
  final Widget child;
  final bool isHomeScreen;
  // final background;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        child: Stack(
          children: <Widget>[
            isHomeScreen ?
            SvgPicture.asset(
              AppImages.backgroundHome,
            ) : Image.asset(
              AppImages.backgroundAppBar,
            ),
            Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                   children: <Widget>[
                      AppBarWidget(), child],
                 ),
                isHomeScreen ? const Spacer() : Container(),
                isHomeScreen ? Container(
                    alignment: Alignment.bottomCenter,
                    child: const BottomNavigationBarWidget()) : Container(),
              ],
            ),
            isHomeScreen ? Positioned(
                height: SizeBlock.v! * 86,
                width: SizeBlock.v! * 84,
                bottom: SizeBlock.v! * 28,
                left: MediaQuery.of(context).size.width / 2 - 42,
                child: GestureDetector(
                  onTap: () {
                    showPopUpWidget(context);
                  },
                  child:
                  Column(children: <Widget>[
                    Container(
                        height: SizeBlock.v! * 66,
                        width: SizeBlock.v! * 66,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  offset: const Offset(1, 1),
                                  blurRadius: 5,
                                  spreadRadius: 1)
                            ],
                            color: AppColors.redDark,
                            border: Border.all(width: 5, color: Colors.white),
                            borderRadius: BorderRadius.circular(50)),
                        child: Container(
                          height: SizeBlock.v! * 36.5,
                          child: SvgPicture.asset(AppIcons.cashinout,
                              semanticsLabel: 'Cash In / Out'),
                        )),
                    // SizedBox(height: SizeBlock.v! * 10),
                    Text('Cash In / Out',
                        style: TextStyle(
                           height: 2,
                            decoration: TextDecoration.none,
                            color: Colors.grey,
                            fontSize: SizeBlock.v! * 10,
                            fontWeight: FontWeight.w500))
                  ]),
                )) : Container(),
          ],
        ),
      ),
    );
  }

}
