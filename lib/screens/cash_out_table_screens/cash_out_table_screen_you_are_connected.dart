import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/app-icons.dart';
import 'package:acresapp/common/helpers/app-images.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:acresapp/screens/cash_out_table_screens/cash_out_table_provider.dart';
import 'package:acresapp/services/bluetooth_service.dart';
import 'package:acresapp/widgets/universal_widgets/app-bar-widget.dart';
import 'package:acresapp/widgets/universal_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class CashOutTableYouAreConnectedScreen extends StatefulWidget {
  String serialNumber;

  CashOutTableYouAreConnectedScreen(this.serialNumber);

  @override
  _CashOutTableYouAreConnectedScreenState createState() =>
      _CashOutTableYouAreConnectedScreenState();
}


class _CashOutTableYouAreConnectedScreenState extends State<CashOutTableYouAreConnectedScreen> {

  BlueToothServiceProvider get blueToothService =>
      GetIt.instance<BlueToothServiceProvider>();

  String transactionSerialNumber = '';
  int amount = 0;
  CashOutTableProvider? cashOutTableProvider;
 
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    cashOutTableProvider = Provider.of<CashOutTableProvider>(context, listen: false);
    cashOutTableProvider!.c2cConnect(context, widget.serialNumber);
    super.initState();
  }

  @override
  void dispose() {
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: SizeBlock.v! * 35,
                              width: SizeBlock.v! * 35,
                              padding: EdgeInsets.all(SizeBlock.v! * 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      width: SizeBlock.v! * 4,
                                      color: AppColors.greenLight)),
                              child: SvgPicture.asset(AppIcons.done),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'You\'re Connected!',
                              style: TextStyle(
                                  fontFamily: 'Korolev',
                                  decoration: TextDecoration.none,
                                  color: AppColors.redDarkText,
                                  fontWeight: FontWeight.w700,
                                  fontSize: SizeBlock.v! * 24),
                            )
                          ],
                        ),
                        SizedBox(height: SizeBlock.v! * 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: <Widget>[
                                SvgPicture.asset(
                                  AppImages.cards,
                                  height: SizeBlock.v! * 42,
                                ),
                                SizedBox(
                                  width: SizeBlock.h! * 5,
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Blackjack',
                                        style: TextStyle(
                                          fontFamily: 'Korolev',
                                          color: Colors.black,
                                          fontSize: SizeBlock.v! * 50,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          'Turn-in Chips, and Notify Dealer\nYou are Using Digital Wallet',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.grey,
                              fontSize: SizeBlock.v! * 18,
                              fontFamily: 'Korolev',
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: SizeBlock.v! * 30),
                        Image.asset(AppImages.fundTableImage,
                          height: SizeBlock.v! * 182,
                          width: SizeBlock.h! * 182,
                        ),
                        SizedBox(height: SizeBlock.v! * 65),
                        Container(
                          margin:
                          EdgeInsets.symmetric(horizontal: SizeBlock.h! * 50),
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(SizeBlock.v! * 10),
                              border: Border.all(color: AppColors.grey)),
                          child: CustomButton(
                            onTap: () async {
                             cashOutTableProvider!.c2cCancelRequest(context, widget.serialNumber);
                            },
                            text: 'CANCEL',
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
                ),
              ],
            ),
          ],
        ));
  }
}
