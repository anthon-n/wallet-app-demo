import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/app-images.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:acresapp/screens/cash_out_table_screens/cash_out_table_provider.dart';
import 'package:acresapp/screens/cash_out_table_screens/transfer_complete_cash_out_tables_screen.dart';
import 'package:acresapp/services/bluetooth_service.dart';
import 'package:acresapp/widgets/universal_widgets/app-bar-widget.dart';
import 'package:acresapp/widgets/universal_widgets/custom_button.dart';
import 'package:acresapp/widgets/tables_and_slots_widgets/red_text_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class CashOutTablesConfirmationScreen extends StatefulWidget {
  int amount;
  String transactionSerialNumber;
  String serialNumber;

  CashOutTablesConfirmationScreen(this.amount, this.transactionSerialNumber, this.serialNumber);

  @override
  _CashOutTablesConfirmationScreenState createState() =>
      _CashOutTablesConfirmationScreenState();
}

class _CashOutTablesConfirmationScreenState extends State<CashOutTablesConfirmationScreen> {
  BlueToothServiceProvider get blueToothService =>
      GetIt.instance<BlueToothServiceProvider>();
   CashOutTableProvider? _cashOutTableProvider;
  @override
  void initState() {
    _cashOutTableProvider = Provider.of<CashOutTableProvider>(context, listen: false);
    super.initState();
  }


  @override
  void dispose() {
    _cashOutTableProvider!.c2cDisconnect(widget.serialNumber);
    super.dispose();
  }

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
                        const SizedBox(height: 25),
                        RedTextCardWidgetTables('Cash-Out Table Game',
                            'Accept Amount or Decline Transaction'),
                        SizedBox(height: SizeBlock.v! * 50),
                        RichText(
                          textAlign: TextAlign.center,
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
                                          fontWeight: FontWeight.w800,
                                          fontSize: SizeBlock.v! * 40)),
                                ),
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.top,
                                baseline: TextBaseline.alphabetic,
                                child: Transform.translate(
                                  offset: const Offset(0.0, 0.0),
                                  child: Text('${widget.amount.toStringAsFixed(2)}',
                                      style: TextStyle(
                                          fontFamily: 'KorolevCompressed',
                                          decoration: TextDecoration.none,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800,
                                          fontSize: SizeBlock.v! * 72)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: SizeBlock.v! * 75),
                        // SvgPicture.asset(AppIcons.mt),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: SizeBlock.h! * 20),
                          child: CustomButton(
                            onTap: () {
                              _cashOutTableProvider!.cashOutTable(context, widget.transactionSerialNumber, widget.amount);
                            },
                            text: 'ACCEPT',
                            color: AppColors.greenLight,
                            textStyle: TextStyle(
                                letterSpacing: SizeBlock.v! * 3,
                                color: AppColors.white,
                                fontSize: SizeBlock.v! * 16,
                                fontFamily: 'Korolev',
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        SizedBox(
                          height: SizeBlock.v! * 15,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: SizeBlock.h! * 20),
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(SizeBlock.v! * 10),
                              border: Border.all(color: AppColors.grey)),
                          child: CustomButton(
                            onTap: () async  {
                              print('cancel2');
                              await blueToothService.c2cCancelRequest(widget.serialNumber);
                              await blueToothService.c2cDisconnect(widget.serialNumber);
                              Navigator.pop(context);
                            },
                            text: 'DECLINE',
                            color: AppColors.white,
                            textStyle:  TextStyle(
                                letterSpacing: SizeBlock.v! * 3,
                                color: Colors.black,
                                fontSize: SizeBlock.v! * 16,
                                fontFamily: 'Korolev',
                                fontWeight: FontWeight.w800),
                          ),
                        ),
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
