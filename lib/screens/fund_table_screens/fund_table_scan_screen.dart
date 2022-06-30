import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/app-icons.dart';
import 'package:acresapp/common/helpers/app-images.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:acresapp/screens/fund_table_screens/transfer_complete_fund_tables_screen.dart';
import 'package:acresapp/widgets/universal_widgets/app-bar-widget.dart';
import 'package:acresapp/widgets/tables_and_slots_widgets/red_text_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FundTableScanScreen extends StatefulWidget {
  @override
  _FundTableScanScreenState createState() => _FundTableScanScreenState();
}

class _FundTableScanScreenState extends State<FundTableScanScreen> {
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
                          AppIcons.three_circle_bar,
                          width: SizeBlock.h! * 190,
                        ),
                        const SizedBox(height: 25),
                        RedTextCardWidgetTables('3. Fund Table Game',
                            'Hold Phone to Dealer Console\nand wait for confirmation.'),
                        const SizedBox(height: 50),
                        // SvgPicture.asset(AppIcons.mt),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push<dynamic>(
                              context,
                              MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) =>
                                      TransferCompleteFundTablesScreen()),
                            );
                          },
                          child: Image.asset(
                            AppImages.connect_fund_tables,
                            height: SizeBlock.v! * 226,
                          ),
                        )
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
