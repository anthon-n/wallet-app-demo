import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/app-images.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:acresapp/models/wallet_model.dart';
import 'package:acresapp/screens/fund_slots_screens/select_screen/fund_slots_provider.dart';
import 'package:acresapp/services/tables_slot_service.dart';
import 'package:acresapp/services/wallet_service.dart';
import 'package:acresapp/widgets/tables_and_slots_widgets/select_amount_container.dart';
import 'package:acresapp/widgets/universal_widgets/custom_keyboard.dart';
import 'package:acresapp/widgets/wallet_widgets/wallet_row/wallet_row_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';
import '../../universal_widgets/custom_button.dart';

class WalletRowWidget extends StatefulWidget {
  WalletRowWidget(this.walletModel, this.tileIndex, [this.scrollController]);

  final WalletModel walletModel;
  int tileIndex;
  final ScrollController? scrollController;
  @override
  _WalletRowWidgetState createState() => _WalletRowWidgetState();
}

class _WalletRowWidgetState extends State<WalletRowWidget> {
  final GlobalKey itemKey = GlobalKey();
  final TextEditingController _priceEditingController = TextEditingController();
  final TextEditingController _pointsEditingController = TextEditingController();

  TablesSlotService get tablesService => GetIt.instance<TablesSlotService>();
  WalletService get walletService => GetIt.instance<WalletService>();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();

  @override
  Widget build(BuildContext context) {
    WalletRowProvider _walletRowProvider = Provider.of<WalletRowProvider>(context, listen: false);
    FundSlotsProvider _fundSlotsProvider =
    Provider.of<FundSlotsProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        _walletRowProvider.changeSelectedAmount(-1);
        _priceEditingController.clear();
      },
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
          key: itemKey,
          padding: EdgeInsets.symmetric(vertical: SizeBlock.v! * 20),
          child: Consumer<WalletRowProvider>(
            builder: (BuildContext context, WalletRowProvider myWalletRowProvider, Widget? child) { 
              return Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      _fundSlotsProvider.expandListTile(widget.tileIndex);
                      _walletRowProvider.scrollToFocusedElement(widget.scrollController!, itemKey);
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text('${widget.walletModel.name}',
                                  style: TextStyle(
                                      fontFamily: 'Korolev',
                                      decoration: TextDecoration.none,
                                      color: AppColors.grey,
                                      fontWeight: FontWeight.w700,
                                      fontSize: SizeBlock.v! * 24)),
                              widget.walletModel.name == 'MarkerTrax'
                                  ? Text('™',
                                  style: TextStyle(
                                      fontFamily: 'Korolev',
                                      decoration: TextDecoration.none,
                                      color: AppColors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: SizeBlock.v! * 16))
                                  : Container(),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              widget.walletModel.name == 'MarkerTrax'
                                  ? Padding(
                                padding:
                                EdgeInsets.only(right: SizeBlock.h! * 5),
                                child: Image.asset(
                                  AppImages.mt,
                                  fit: BoxFit.fill,
                                  height: SizeBlock.v! * 32,
                                ),
                              )
                                  : Container(),
                              RichText(
                                text: TextSpan(
                                  children: <InlineSpan>[
                                    widget.walletModel.type != 2
                                        ? WidgetSpan(
                                      alignment: PlaceholderAlignment.top,
                                      baseline: TextBaseline.alphabetic,
                                      child: Transform.translate(
                                        offset: const Offset(0.0, 2.0),
                                        child: Text('\$',
                                            style: TextStyle(
                                                fontFamily:
                                                'KorolevCompressed',
                                                decoration:
                                                TextDecoration.none,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                                fontSize: SizeBlock.v! * 23)),
                                      ),
                                    )
                                        : const WidgetSpan(
                                      child: Text(
                                        '',
                                      ),
                                    ),
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.top,
                                      baseline: TextBaseline.alphabetic,
                                      child: Transform.translate(
                                        offset: const Offset(0.0, 0.0),
                                        child: Text(
                                            (widget.walletModel.type == 2)
                                                ? '${widget.walletModel.balance!}'
                                                : '${(widget.walletModel.balance! / 100).toStringAsFixed(2)}',
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
                            ],
                          ),
                        ]),
                  ),
                  Consumer<FundSlotsProvider>(
                    builder:
                        (BuildContext context, _fundSlotsProvider, Widget? child) {
                      if (_fundSlotsProvider.expandedTileIndex ==
                          widget.tileIndex) {
                        return (widget.walletModel.type != 2)
                            ? Padding(
                          padding: EdgeInsets.only(top: SizeBlock.v! * 10),
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: SizeBlock.v! * 44,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      SizeBlock.v! * 10),
                                  color: AppColors.lightGrey,
                                ),
                                child: KeyboardActions(
                                  disableScroll: true,
                                  config: CustomKeyboard.buildConfig(context, _nodeText1),
                                  child: TextField(
                                    focusNode: _nodeText1,
                                    controller: _priceEditingController,
                                    onChanged: (String value) {
                                      _walletRowProvider.changeSelectedAmount(-1);
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
                                      isDense: true,
                                      border: InputBorder.none,
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
                              SizedBox(height: SizeBlock.v! * 10),
                              SizedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    (widget.walletModel.balance as int >=
                                        2000)
                                        ? GestureDetector(
                                      onTap: () {
                                        _priceEditingController.text = '20';
                                        _walletRowProvider.changeSelectedAmount(0);
                                      },
                                      child: SelectAmountContainer(
                                        color: (myWalletRowProvider.selectedAmount == 0)
                                            ? AppColors.redDark
                                            : AppColors.grey,
                                        amount: '20',
                                      ),
                                    )
                                        : Container(),
                                    (widget.walletModel.balance as int >=
                                        2000)
                                        ? SizedBox(
                                      width: SizeBlock.v! * 15,
                                    ) : Container(),
                                    (widget.walletModel.balance as int >=
                                        5000)
                                        ? GestureDetector(
                                      onTap: () {
                                        _priceEditingController.text =
                                        '50';
                                        _walletRowProvider.changeSelectedAmount(1);
                                      },
                                      child: SelectAmountContainer(
                                        color: (myWalletRowProvider.selectedAmount == 1)
                                            ? AppColors.redDark
                                            : AppColors.grey,
                                        amount: '50',
                                      ),
                                    )
                                        : Container(),
                                    (widget.walletModel.balance as int >=
                                        5000)
                                        ? SizedBox(
                                      width: SizeBlock.v! * 15,
                                    ) : Container(),
                                    GestureDetector(
                                      onTap: () {
                                        _priceEditingController.text =
                                        '${(widget.walletModel.balance! / 100).toStringAsFixed(2)}';
                                        _walletRowProvider.changeSelectedAmount(2);
                                      },
                                      child: SelectAmountContainer(
                                          color: (myWalletRowProvider.selectedAmount == 2)
                                              ? AppColors.redDark
                                              : AppColors.grey,
                                          amount: 'MAX'),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: SizeBlock.v! * 10),
                              CustomButton(
                                onTap: () async {
                                  _walletRowProvider.transferDollars(context, priceEditingControllerText: _priceEditingController.text, walletModel: widget.walletModel);
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
                            ],
                          ),
                        )
                            : Padding(
                          padding: EdgeInsets.only(top: SizeBlock.v! * 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Convert Points To Free Play",
                                style: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: SizeBlock.v! * 18,
                                    fontFamily: 'Korolev',
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: SizeBlock.v! * 10,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    (widget.walletModel.balance as int >= 20)
                                        ? GestureDetector(
                                      onTap: () {
                                        _pointsEditingController
                                            .text = '20';
                                        _priceEditingController.text =
                                        '\$${(20 / 5).toStringAsFixed(2)}';
                                        _walletRowProvider.changeSelectedAmount(0);
                                      },
                                      child: SelectAmountContainer(
                                        color: (myWalletRowProvider.selectedAmount == 0)
                                            ? AppColors.redDark
                                            : AppColors.grey,
                                        amount: '20',
                                        isDollarSignNeeded: false,
                                      ),
                                    )
                                        : Container(),
                                    SizedBox(
                                      width: SizeBlock.v! * 15,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _walletRowProvider.changeSelectedAmount(1);
                                        _pointsEditingController.text =
                                        '${widget.walletModel.balance}';
                                        _priceEditingController.text =
                                        '\$${(widget.walletModel.balance! / 5).toStringAsFixed(2)}';
                                      },
                                      child: SelectAmountContainer(
                                        color: (myWalletRowProvider.selectedAmount == 1)
                                            ? AppColors.redDark
                                            : AppColors.grey,
                                        amount: 'MAX',
                                        isDollarSignNeeded: false,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: SizeBlock.v! * 10,
                              ),
                              Container(
                                height: SizeBlock.v! * 44,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      SizeBlock.v! * 10),
                                  color: AppColors.lightGrey,
                                ),
                                child: KeyboardActions(
                                  disableScroll: true,
                                  config: CustomKeyboard.buildConfig(context, _nodeText2),
                                  child: TextField(
                                    focusNode: _nodeText2,
                                    controller: _pointsEditingController,
                                    onChanged: (String value) {
                                      _walletRowProvider.changeSelectedAmount(-1);
                                      if (value.isEmpty) {
                                        _priceEditingController.text = '';
                                      } else {
                                        _priceEditingController.text =
                                        '\$${(int.parse(value) / 5)
                                            .toStringAsFixed(2)}';
                                      }
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
                                      isDense: true,
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintText: 'Amount Of Points To Convert',
                                      hintStyle: TextStyle(
                                          color: AppColors.grey,
                                          fontSize: SizeBlock.v! * 20,
                                          fontFamily: 'Korolev',
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: SizeBlock.v! * 10,
                              ),
                              Text(
                                '- EQUALS -',
                                style: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: SizeBlock.v! * 18,
                                    fontFamily: 'Korolev',
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: SizeBlock.v! * 10,
                              ),
                              Container(
                                  height: SizeBlock.v! * 44,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        SizeBlock.v! * 10),
                                    color: AppColors.lightGrey,
                                  ),
                                  child: Center(
                                    child: Text(
                                      _priceEditingController.text,
                                      style: TextStyle(
                                          color: AppColors.grey,
                                          fontSize: SizeBlock.v! * 20,
                                          fontFamily: 'Korolev',
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )),
                              SizedBox(height: SizeBlock.v! * 10),
                              CustomButton(
                                onTap: () async {
                                  _walletRowProvider.transferPoints(context, pointsEditingControllerText: _pointsEditingController.text, walletModel: widget.walletModel);
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
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              );
            },
          )),
    );
  }
}