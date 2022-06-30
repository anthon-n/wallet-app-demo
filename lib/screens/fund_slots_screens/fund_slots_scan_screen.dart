import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/app-icons.dart';
import 'package:acresapp/common/helpers/app-images.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:acresapp/widgets/universal_widgets/app-bar-widget.dart';
import 'package:acresapp/widgets/tables_and_slots_widgets/red_text_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'fund_slots_transfer_screen.dart';

class FundSlotsScanScreen extends StatefulWidget {
  @override
  _FundSlotsScanScreenState createState() => _FundSlotsScanScreenState();
}

class _FundSlotsScanScreenState extends State<FundSlotsScanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: Stack(
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                 AppBarWidget(),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: SizeBlock.v! * 100),
                        Image.asset(
                          AppIcons.one_circle_bar,
                          width: SizeBlock.h! * 190,
                        ),
                        const SizedBox(height: 25),
                        RedTextCardWidgetSlots('1. Fund Slots',
                            'Place phone close to the slot machine\nand wait for connection confirmation'),
                        const SizedBox(height: 50),
                        // SvgPicture.asset(AppIcons.mt),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.pop(context);
                        //     Navigator.push<dynamic>(
                        //       context,
                        //       MaterialPageRoute<dynamic>(
                        //           builder: (BuildContext context) =>
                        //               FundSlotsTransferScreen()),
                        //     );
                        //   },
                        //   child: Image.asset(
                        //     AppImages.connect_fund_slots,
                        //     height: SizeBlock.v! * 226,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
