import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/app-icons.dart';
import 'package:acresapp/common/helpers/app-images.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:acresapp/providers/tab_view_cash_out_fund_slots_provider.dart';
import 'package:acresapp/widgets/universal_widgets/app-bar-widget.dart';
import 'package:acresapp/widgets/universal_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class TransferCompleteFundSlotsScreen extends StatefulWidget {
  double amount;
  TransferCompleteFundSlotsScreen({required this.amount});
  @override
  _TransferCompleteFundSlotsScreenState createState() =>
      _TransferCompleteFundSlotsScreenState();
}

class _TransferCompleteFundSlotsScreenState
    extends State<TransferCompleteFundSlotsScreen> {
  @override
  Widget build(BuildContext context) {
    TabViewCashOutFundSlotsProvider _tabViewCashOutFundSlotsProvider = Provider.of<TabViewCashOutFundSlotsProvider>(context, listen: false);
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
          Container(
           // padding: EdgeInsets.symmetric(horizontal: SizeBlock.v! * 25),
            child: Column(children: <Widget>[
               AppBarWidget(),
              SizedBox(height: SizeBlock.v! * 85),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeBlock.v! * 25),
                child: Column(
                  children: [
                    Container(
                      height: SizeBlock.v! * 175,
                      width: SizeBlock.v! * 175,
                      padding: EdgeInsets.all(SizeBlock.v! * 45),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(SizeBlock.v! * 100),
                          border: Border.all(
                              width: SizeBlock.v! * 7, color: AppColors.greenLight)),
                      child: SvgPicture.asset(AppIcons.done),
                    ),
                    SizedBox(
                      height: SizeBlock.v! * 30,
                    ),
                    Text(
                      'Transfer Complete',
                      style: TextStyle(
                          color: AppColors.redDarkText,
                          fontSize: SizeBlock.v! * 24,
                          fontFamily: 'Korolev',
                          fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: SizeBlock.v! * 5,
                    ),
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
                                      fontSize: SizeBlock.v! * 22)),
                            ),
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.top,
                            baseline: TextBaseline.alphabetic,
                            child: Transform.translate(
                              offset: const Offset(0.0, 0.0),
                              child: Text(widget.amount.toStringAsFixed(2),
                                  style: TextStyle(
                                      fontFamily: 'KorolevCompressed',
                                      decoration: TextDecoration.none,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: SizeBlock.v! * 36)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeBlock.v! * 5,
                    ),
                    Text(
                      'Has been Added to ${_tabViewCashOutFundSlotsProvider.deviceModel!.gameTheme}',
                      style: TextStyle(
                          color: AppColors.grey,
                          fontSize: SizeBlock.v! * 18,
                          fontFamily: 'Korolev',
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: SizeBlock.v! * 70,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(SizeBlock.v! * 10),
                          border: Border.all(color: AppColors.grey)),
                      child: CustomButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        text: 'RETURN TO HOMESCREEN',
                        color: AppColors.white,
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: SizeBlock.v! * 16,
                            fontFamily: 'Korolev',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2),
                      ),
                    ),
                  ],
                ),
              ),

            ]),
          ),
        ],
      )
    );
  }
}
