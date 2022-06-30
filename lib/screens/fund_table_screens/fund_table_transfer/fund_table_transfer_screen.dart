import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/app-icons.dart';
import 'package:acresapp/common/helpers/app-images.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:acresapp/common/loaded_data.dart';
import 'package:acresapp/screens/fund_table_screens/fund_table_game_select/fund_table_game_select_screen.dart';
import 'package:acresapp/screens/fund_table_screens/fund_table_transfer/fund_table_transfer_provider.dart';
import 'package:acresapp/services/bluetooth_service.dart';
import 'package:acresapp/widgets/universal_widgets/build_divider.dart';
import 'package:acresapp/widgets/tables_and_slots_widgets/select_amount_container.dart';
import 'package:acresapp/widgets/universal_widgets/app-bar-widget.dart';
import 'package:acresapp/widgets/universal_widgets/custom_button.dart';
import 'package:acresapp/widgets/universal_widgets/custom_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';
import '../fund_table_provider.dart';

class FundTableTransferScreen extends StatefulWidget {
  String serialNumber;

  FundTableTransferScreen(this.serialNumber);

  @override
  _FundTableTransferScreenState createState() =>
      _FundTableTransferScreenState();
}

class _FundTableTransferScreenState extends State<FundTableTransferScreen> {
  final TextEditingController _priceEditingController = TextEditingController();
  final FocusNode _nodeText = FocusNode();
  BlueToothServiceProvider get blueToothService =>
      GetIt.instance<BlueToothServiceProvider>();

  ScrollController _scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    final FundTableProvider _fundTableProvider =
    Provider.of<FundTableProvider>(context, listen: false);
    final FundTableTransferProvider _fundTableTransferProvider =
    Provider.of<FundTableTransferProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
            Consumer<FundTableTransferProvider>(
              builder: (BuildContext context, FundTableTransferProvider myFundTableTransferProvider, Widget? child) {
                return  Column(
                  children: <Widget>[
                    AppBarWidget(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: SizeBlock.v! * 20),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: SizeBlock.v! * 85),
                          Image.asset(
                            AppIcons.one_circle_bar,
                            width: SizeBlock.h! * 190,
                          ),
                          SizedBox(height: SizeBlock.v! * 25),
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
                            'Any transfers you make will go to Blackjack',
                            style: TextStyle(
                                color: AppColors.grey,
                                fontSize: SizeBlock.v! * 18,
                                fontFamily: 'Korolev',
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: SizeBlock.v! * 20),
                          buildDivider(),
                        ],
                      ),
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          padding: EdgeInsets.only(left: SizeBlock.v! * 20, right: SizeBlock.v! * 20, bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: SizeBlock.v! * 20),
                              Consumer<LoadedDataProvider>(
                                builder: (BuildContext context, LoadedDataProvider _myLoadedDataProvider, Widget? child) {
                                  if (_myLoadedDataProvider.loadedWallets.isNotEmpty) {
                                    return Column(
                                      children: [
                                        Text(
                                          'Select an amount from your wallet',
                                          style: TextStyle(
                                              color: AppColors.grey,
                                              fontSize: SizeBlock.v! * 18,
                                              fontFamily: 'Korolev',
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(height: SizeBlock.v! * 10),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            (_myLoadedDataProvider.loadedWallets
                                                .elementAt(0)['balance'] as int >=
                                                20)
                                                ? GestureDetector(
                                              onTap: () {
                                                _fundTableTransferProvider.changeSelectedAmount(0);
                                                _priceEditingController.text = '20';

                                              },
                                              child: SelectAmountContainer(
                                                color: (myFundTableTransferProvider.selectedAmount == 0)
                                                    ? AppColors.redDark
                                                    : AppColors.grey,
                                                amount: '20',
                                              ),
                                            )
                                                : Container(),
                                            (_myLoadedDataProvider.loadedWallets
                                                .elementAt(0)['balance'] as int >=
                                                50)
                                                ? GestureDetector(
                                              onTap: () {
                                                _priceEditingController.text = '50';
                                                _fundTableTransferProvider.changeSelectedAmount(1);
                                              },
                                              child: SelectAmountContainer(
                                                color: (myFundTableTransferProvider.selectedAmount == 1)
                                                    ? AppColors.redDark
                                                    : AppColors.grey,
                                                amount: '50',
                                              ),
                                            )
                                                : Container(),
                                            GestureDetector(
                                              onTap: () {
                                                _fundTableTransferProvider.changeSelectedAmount(2);
                                                _priceEditingController.text =
                                                '${(_myLoadedDataProvider.loadedWallets.elementAt(0)['balance'] / 100).toStringAsFixed(2)}';
                                              },
                                              child: SelectAmountContainer(
                                                color: (myFundTableTransferProvider.selectedAmount == 2)
                                                    ? AppColors.redDark
                                                    : AppColors.grey,
                                                amount: 'MAX',
                                                isDollarSignNeeded: false,

                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: SizeBlock.v! * 10),
                                        Text('-OR-',
                                            style: TextStyle(
                                                fontFamily: 'Korolev',
                                                decoration: TextDecoration.none,
                                                color: AppColors.grey,
                                                fontWeight: FontWeight.w600,
                                                fontSize: SizeBlock.v! * 18)),
                                        SizedBox(height: SizeBlock.v! * 10),

                                      ],
                                    );
                                  }
                                  return Container();
                                },

                              ),
                              Container(
                                height: SizeBlock.v! * 44,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(SizeBlock.v! * 10),
                                  color: AppColors.lightGrey,
                                ),
                                child: Center(
                                  child: KeyboardActions(
                                    disableScroll: true,
                                    config: CustomKeyboard.buildConfig(context, _nodeText),
                                    child: TextField(
                                      onTap: () {_scrollController.jumpTo(SizeBlock.v! * 130);},
                                      focusNode: _nodeText,
                                      controller: _priceEditingController,
                                      onChanged: (String value) {
                                        _fundTableTransferProvider.changeSelectedAmount(-1);
                                      },
                                      textAlign: TextAlign.center,
                                      cursorColor: AppColors.redDarkText,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                          color: AppColors.grey,
                                          fontSize: SizeBlock.v! * 20,
                                          fontFamily: 'Korolev',
                                          fontWeight: FontWeight.w600),
                                      decoration: InputDecoration(
                                        // contentPadding: EdgeInsets.symmetric(
                                        //     horizontal: SizeBlock.h! * 10),
                                        border: InputBorder.none,
                                        isDense: true,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        hintText: 'Enter Amount',
                                        hintStyle: TextStyle(
                                            color: AppColors.grey,
                                            fontSize: SizeBlock.v! * 20,
                                            fontFamily: 'Korolev',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: SizeBlock.v! * 7),
                              CustomButton(
                                onTap: () async {
                                  _fundTableProvider.transfer(context, chosenAmount: myFundTableTransferProvider.selectedAmount, priceEditingControllerText: _priceEditingController.text, serialNumber: widget.serialNumber);
                                },
                                text: 'TRANSFER',
                                color: AppColors.redDark,
                                textStyle: TextStyle(
                                    letterSpacing: SizeBlock.v! * 3,
                                    color: AppColors.white,
                                    fontSize: SizeBlock.v! * 20,
                                    fontFamily: 'Korolev',
                                    fontWeight: FontWeight.w800),
                              ),
                              SizedBox(height: SizeBlock.v! * 10),
                              Text('-OR-',
                                  style: TextStyle(
                                      fontFamily: 'Korolev',
                                      decoration: TextDecoration.none,
                                      color: AppColors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: SizeBlock.v! * 18)),
                              SizedBox(height: SizeBlock.v! * 15),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push<dynamic>(
                                    context,
                                    MaterialPageRoute<dynamic>(
                                        builder: (BuildContext context) =>
                                            FundTableGameSelectScreen(widget.serialNumber)),
                                  );
                                },
                                child: Text(
                                  '\“Non-Cash\“ Funding options,\nlike Free Play or Points.',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      decoration: TextDecoration.underline,
                                      fontSize: SizeBlock.v! * 18,
                                      fontFamily: 'Korolev',
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(height: SizeBlock.v! * 15),
                              buildDivider(),
                              SizedBox(height: SizeBlock.v! * 50),
                              Container(
                                margin:
                                EdgeInsets.symmetric(horizontal: SizeBlock.h! * 50),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(SizeBlock.v! * 10),
                                    border: Border.all(color: AppColors.grey)),
                                child: CustomButton(
                                  onTap: () {
                                    Navigator.pop(context);
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
                        )),
                  ],
                );
              },

            ),
          ],
        ),
      ),
    );
  }


}


