import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/app-icons.dart';
import 'package:acresapp/common/helpers/app-images.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:acresapp/common/loaded_data.dart';
import 'package:acresapp/models/device_model.dart';
import 'package:acresapp/providers/tab_view_cash_out_fund_slots_provider.dart';
import 'package:acresapp/providers/timer_provider.dart';
import 'package:acresapp/screens/fund_slots_screens/select_screen/fund_slots_provider.dart';
import 'package:acresapp/widgets/universal_widgets/build_divider.dart';
import 'package:acresapp/screens/fund_slots_screens/transfer_complete_fund_slots_screen.dart';
import 'package:acresapp/screens/main_tab_view_cash_out_fund_slots.dart';
import 'package:acresapp/widgets/tables_and_slots_widgets/select_amount_container.dart';
import 'package:acresapp/widgets/universal_widgets/app-bar-widget.dart';
import 'package:acresapp/widgets/universal_widgets/bottom-navigation-bar.widget.dart';
import 'package:acresapp/widgets/universal_widgets/custom_button.dart';
import 'package:acresapp/widgets/universal_widgets/custom_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';

class FundSlotsTransferScreen extends StatefulWidget {
  DeviceModel deviceModel;
  FundSlotsTransferScreen(this.deviceModel);
  @override
  _FundSlotsTransferScreenState createState() =>
      _FundSlotsTransferScreenState();
}

class _FundSlotsTransferScreenState extends State<FundSlotsTransferScreen> {
  int chosenAmount = -1;
  TimerProvider? timerProvider;

  @override
  void initState() {
    super.initState();
    timerProvider = Provider.of<TimerProvider>(context, listen: false);
  }


  final TextEditingController _priceEditingController = TextEditingController();
  final FocusNode _nodeText = FocusNode();
  ScrollController _scrollController = ScrollController();



  @override
  Widget build(BuildContext context) {
    final TabViewCashOutFundSlotsProvider _tabViewCashOutFundSlotsProvider = Provider.of<TabViewCashOutFundSlotsProvider>(context, listen: false);
    _tabViewCashOutFundSlotsProvider.deviceModel = widget.deviceModel;
    final FundSlotsProvider _fundSlotsProvider =
        Provider.of<FundSlotsProvider>(context, listen: false);
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
            Column(
              children: <Widget>[
                AppBarWidget(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeBlock.v! * 20),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: SizeBlock.v! * 85),
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
                      SizedBox(height: SizeBlock.v! * 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              SvgPicture.asset(
                                AppImages.slotMachine,
                                height: SizeBlock.v! * 42,
                              ),
                              SizedBox(
                                width: SizeBlock.h! * 5,
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '${widget.deviceModel.gameTheme}',
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
                          Row(
                            children: <Widget>[
                              buildIconWithTextVertical(
                                  AppIcons.timer, 'TIMER'),
                              SizedBox(width: SizeBlock.h! * 10),
                              Consumer<TimerProvider>(
                                builder: (BuildContext context, TimerProvider _myTimerProvider, Widget? child) {
                                  print(_myTimerProvider.secondsLeft);
                                  if (_myTimerProvider.secondsLeft <= 0) {
                                    FocusScope.of(context).unfocus();
                                    //popping the currentPage
                                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                                      Navigator.maybePop(context);
                                    });
                                    return Container();
                                  } else {
                                    return Text(
                                      ':${_myTimerProvider.secondsLeft}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'KorolevCompressed',
                                          fontSize: SizeBlock.v! * 36,
                                          fontWeight: FontWeight.w700),
                                    );
                                  }
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                      Text(
                        'Any transfers you make will go to ${widget.deviceModel.gameTheme}',
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
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: _scrollController,
                      padding: EdgeInsets.only(left: SizeBlock.v! * 20, right: SizeBlock.v! * 20, bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Column(
                    children: <Widget>[
                      SizedBox(height: SizeBlock.v! * 20),
                      Text(
                        'Select an amount from your wallet',
                        style: TextStyle(
                            color: AppColors.grey,
                            fontSize: SizeBlock.v! * 18,
                            fontFamily: 'Korolev',
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: SizeBlock.v! * 10),
                      Consumer<LoadedDataProvider>(
                        builder: (BuildContext context, _loadedDataProvider,
                            Widget? child) {
                          if (_loadedDataProvider.loadedWallets.isEmpty) {
                            return Container();
                          } else {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                (_loadedDataProvider.loadedWallets
                                            .elementAt(0)['balance'] as int >=
                                        2000)
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _priceEditingController.text = '20';
                                            if (chosenAmount == 0) {
                                              chosenAmount = -1;
                                            } else {
                                              chosenAmount = 0;
                                            }
                                          });
                                        },
                                        child: SelectAmountContainer(
                                          color: (chosenAmount == 0)
                                              ? AppColors.redDark
                                              : AppColors.grey,
                                          amount: '20',
                                        ),
                                      )
                                    : Container(),
                                SizedBox(width: SizeBlock.v! * 15,),
                                (_loadedDataProvider.loadedWallets
                                            .elementAt(0)['balance'] as int >=
                                        5000)
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _priceEditingController.text = '50';
                                            if (chosenAmount == 1) {
                                              chosenAmount = -1;
                                            } else {
                                              chosenAmount = 1;
                                            }
                                          });
                                        },
                                        child: SelectAmountContainer(
                                          color: (chosenAmount == 1)
                                              ? AppColors.redDark
                                              : AppColors.grey,
                                          amount: '50',
                                        ),
                                      )
                                    : Container(),
                                SizedBox(width: SizeBlock.v! * 15,),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _priceEditingController.text =
                                          '${((_loadedDataProvider.loadedWallets.elementAt(0)['balance'] as int) / 100).toStringAsFixed(2)}';
                                      if (chosenAmount == 2) {
                                        chosenAmount = -1;
                                      } else {
                                        chosenAmount = 2;
                                      }
                                    });
                                  },
                                  child: SelectAmountContainer(
                                    color: (chosenAmount == 2)
                                        ? AppColors.redDark
                                        : AppColors.grey,
                                    amount: 'MAX',
                                    isDollarSignNeeded: false,
                                  ),
                                ),
                              ],
                            );
                          }
                        },
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
                              onTap: () {_scrollController.animateTo(SizeBlock.v! * 50, curve: Curves.linear, duration: const Duration(milliseconds: 1), );},
                              focusNode: _nodeText,
                              controller: _priceEditingController,
                              onChanged: (String value) {
                                setState(() {
                                  chosenAmount = -1;
                                });
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
                        onTap: () {
                          double amount = 0;
                          if (chosenAmount == 0) {
                            amount = 20;
                          } else if (chosenAmount == 1) {
                            amount = 50;
                          } else if (chosenAmount == 2) {
                            amount = double.parse(_priceEditingController.text);
                          } else if (_priceEditingController.text != '') {
                            amount = double.parse(_priceEditingController.text);
                          }
                          _fundSlotsProvider.fundSlot(
                              context, '${widget.deviceModel.sasSerialNumber}', amount, '0', () {
                                timerProvider!.resetTimer();
                                Navigator.pop(context);
                                Navigator.push<dynamic>(
                                  context,
                                  MaterialPageRoute<dynamic>(
                                      builder: (BuildContext context) =>
                                          TransferCompleteFundSlotsScreen(
                                            amount: amount,
                                          )),
                            );
                          });
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
                          _tabViewCashOutFundSlotsProvider.displayFundSlotsView();
                          Navigator.pop(context);
                          Navigator.push<dynamic>(
                            context,
                            MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) =>
                                    MainTabViewCashOutFundSlots(widget.deviceModel)),
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
                            timerProvider!.resetTimer();
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
            ),
          ],
        ),
      ),
    );
  }
}
