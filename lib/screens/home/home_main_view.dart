import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/app-icons.dart';
import 'package:acresapp/common/helpers/app-images.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:acresapp/providers/home_page_provider.dart';
import 'package:acresapp/widgets/pop_up_view_widgets/pop_up_view.dart';
import 'package:acresapp/widgets/universal_widgets/app-bar-widget.dart';
import 'package:acresapp/widgets/universal_widgets/bottom-navigation-bar.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomeMainView extends StatelessWidget {
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
          padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          reverse: true,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Consumer<HomePageProvider>(
                  builder: (BuildContext context, _homePageProvider, Widget? child) {
                    if (_homePageProvider.pageDisplayedName == 'HOME') {
                      return SvgPicture.asset(
                        AppImages.backgroundHome,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fitWidth,
                      );
                    } else {
                      return Positioned(
                        top: -SizeBlock.v! * 450,
                        bottom: SizeBlock.v! * 360,
                        child: SvgPicture.asset(
                          AppImages.backgroundHome,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                        ),
                      );
                    }
                  },
                ),
                Column(
                  children: [
                    AppBarWidget(isClickable: true,),
                    Expanded(
                      child: Consumer<HomePageProvider>(
                        builder: (BuildContext context, _homePageProvider, Widget? child) {
                          return _homePageProvider.widgetsToDisplay;
                        },
                      ),
                    ),
                    const BottomNavigationBarWidget(),
                  ],
                ),
                Positioned(
                    height: SizeBlock.v! * 86,
                    bottom: SizeBlock.v! * 28,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              showPopUpWidget(context);
                            },
                            child: Column(children: <Widget>[
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
                                      border:
                                      Border.all(width: SizeBlock.v! * 5, color: Colors.white),
                                      borderRadius: BorderRadius.circular(
                                          SizeBlock.v! * 100)),
                                  child: Container(
                                    height: SizeBlock.v! * 36.5,
                                    child: SvgPicture.asset(AppIcons.cashinout,
                                        semanticsLabel: 'Cash In / Out'),
                                  )),
                              SizedBox(height: SizeBlock.v! * 5),
                            ]),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

}