import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/app-images.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:acresapp/models/wallet_model.dart';
import 'package:acresapp/screens/fund_table_screens/fund_table_game_select/fund_table_game_select_provider.dart';
import 'package:acresapp/screens/fund_table_screens/fund_table_wait_for_confirmation_screen.dart';
import 'package:acresapp/services/tables_slot_service.dart';
import 'package:acresapp/services/wallet_service.dart';
import 'package:acresapp/widgets/fund_table_widgets/fund_table_row/fund_table_row_provider.dart';
import 'package:acresapp/widgets/tables_and_slots_widgets/select_amount_container.dart';
import 'package:acresapp/widgets/universal_widgets/custom_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';
import '../../universal_widgets/custom_button.dart';

class FundTableRowWidget extends StatefulWidget {
  FundTableRowWidget(
      this.walletModel,
      this.tileIndex,
      this.serialNumber
      );

  final WalletModel walletModel;
  int tileIndex;
  String serialNumber;

  @override
  _FundTableRowWidgetState createState() => _FundTableRowWidgetState();
}

class _FundTableRowWidgetState extends State<FundTableRowWidget> {
  FundTableRowProvider? _fundTableRowProvider;
  final TextEditingController _priceEditingController = TextEditingController();
  TablesSlotService get tablesService => GetIt.instance<TablesSlotService>();
  WalletService get walletService => GetIt.instance<WalletService>();
  final FocusNode _nodeText = FocusNode();

  @override
  void initState() {
    _fundTableRowProvider = Provider.of<FundTableRowProvider>(context, listen: false);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    FundTableGameSelectProvider _fundTableGameSelectProvider =
    Provider.of<FundTableGameSelectProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        _fundTableRowProvider!.changeSelectedAmount(-1);
        _fundTableGameSelectProvider.expandListTile(widget.tileIndex);
      },
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Consumer<FundTableRowProvider>(
        builder: (BuildContext context, myFundTableRowProvider, Widget? child) {
          return Container(
              padding: EdgeInsets.symmetric(vertical: SizeBlock.v! * 20),
              child: Column(
                children: <Widget>[
                  Row(
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
                                  widget.walletModel.cashable as bool
                                      ? WidgetSpan(
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
                                      child:  Text((widget.walletModel.type == 0) ? '${(widget.walletModel.balance! / 100).toStringAsFixed(2)}' : '${(widget.walletModel.balance! / 100).toStringAsFixed(0)}',
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
                  Consumer<FundTableGameSelectProvider>(
                    builder:
                        (BuildContext context, _fundTableGameSelectProvider, Widget? child) {
                      if (_fundTableGameSelectProvider.expandedTileIndex ==
                          widget.tileIndex) {
                        return Padding(
                          padding: EdgeInsets.only(top: SizeBlock.v! * 10),
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: SizeBlock.v! * 44,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(SizeBlock.v! * 10),
                                  color: AppColors.lightGrey,
                                ),
                                child: KeyboardActions(
                                  disableScroll: true,
                                  config: CustomKeyboard.buildConfig(context, _nodeText),
                                  child: TextField(
                                    focusNode: _nodeText,
                                    controller: _priceEditingController,
                                    onChanged: (String value) {
                                      _fundTableRowProvider!.changeSelectedAmount(-1);
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
                                    (widget.walletModel.balance as int >
                                        2000) ?
                                    GestureDetector(
                                      onTap: () {
                                        _priceEditingController.text = '20';
                                        _fundTableRowProvider!.changeSelectedAmount(0);
                                      },
                                      child: SelectAmountContainer(
                                        color: (myFundTableRowProvider.selectedAmount == 0)
                                            ? AppColors.redDark
                                            : AppColors.grey,
                                        amount: '20',
                                        isDollarSignNeeded: (widget.walletModel.type == 0) ? true : false,
                                      ),
                                    ) : Container(),
                                    (widget.walletModel.balance as int >
                                        2000) ? SizedBox(
                                      width: SizeBlock.v! * 15,
                                    ) : Container(),
                                    (widget.walletModel.balance as int >
                                        5000) ?
                                    GestureDetector(
                                      onTap: () {
                                        _priceEditingController.text = '50';
                                        _fundTableRowProvider!.changeSelectedAmount(1);
                                      },
                                      child: SelectAmountContainer(
                                        color: (myFundTableRowProvider.selectedAmount == 1)
                                            ? AppColors.redDark
                                            : AppColors.grey,
                                        amount: '50',
                                        isDollarSignNeeded:  (widget.walletModel.type == 0) ? true : false,
                                      ),
                                    ) : Container(),
                                    (widget.walletModel.balance as int >
                                        5000) ? SizedBox(
                                      width: SizeBlock.v! * 15,
                                    ) : Container(),
                                    GestureDetector(
                                      onTap: () {
                                        _priceEditingController.text = (widget.walletModel.type == 0) ? '${(widget.walletModel.balance! / 100).toStringAsFixed(2)}' : '${(widget.walletModel.balance! / 100).toStringAsFixed(0)}';
                                        _fundTableRowProvider!.changeSelectedAmount(2);
                                      },
                                      child: SelectAmountContainer(
                                        color: (myFundTableRowProvider.selectedAmount == 2)
                                            ? AppColors.redDark
                                            : AppColors.grey,
                                        amount: 'MAX',
                                        isDollarSignNeeded: false,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: SizeBlock.v! * 10),
                              CustomButton(
                                onTap: () async {
                                  _fundTableRowProvider!.transfer(context, priceEditingControllerText: _priceEditingController.text, serialNumber: widget.serialNumber, type: '${widget.walletModel.type}');
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
              ));
        },
      ),
    );
  }
}