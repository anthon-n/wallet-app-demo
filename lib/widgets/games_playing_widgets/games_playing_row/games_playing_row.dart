import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:acresapp/models/game_model.dart';
import 'package:acresapp/screens/cash_out_slots_screens/select_screen/cash_out_slots_provider.dart';
import 'package:acresapp/screens/cash_out_slots_screens/transfer_complete_cash_out_slots.dart';
import 'package:acresapp/services/game_service.dart';
import 'package:acresapp/widgets/games_playing_widgets/games_playing_row/games_playing_row_provider.dart';
import 'package:acresapp/widgets/universal_widgets/custom_button.dart';
import 'package:acresapp/widgets/universal_widgets/custom_keyboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';
import '../letter_game_container_widget.dart';

class GamesPlayingRowWidget extends StatefulWidget {
  GameModel gameModel;
  Color color;
  int tileIndex;

  GamesPlayingRowWidget({
    required this.gameModel,
    required this.tileIndex,
    required this.color,
  });

  @override
  _GamesPlayingRowWidgetState createState() => _GamesPlayingRowWidgetState();
}

class _GamesPlayingRowWidgetState extends State<GamesPlayingRowWidget> {

  TextEditingController _priceEditingController = TextEditingController();
  final FocusNode _nodeText = FocusNode();

  GamesPlayingRowProvider? _gamesPlayingRowProvider;

  @override
  void initState() {
    _gamesPlayingRowProvider = Provider.of<GamesPlayingRowProvider>(context, listen: false);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    CashOutSlotsProvider _cashOutSlotsProvider =
        Provider.of<CashOutSlotsProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        _cashOutSlotsProvider.expandListTile(widget.tileIndex);
      },
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: SizeBlock.v! * 10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  LetterGameContainerWidget(
                      ('${widget.gameModel.device!.gameTheme}'.length > 0) ?  '${widget.gameModel.device!.gameTheme[0]}' : '',
                      widget.color),
                  SizedBox(
                    width: SizeBlock.h! * 10,
                  ),
                  SizedBox(
                    width: SizeBlock.h! * 156,
                    child: Text(
                      '${widget.gameModel.device!.gameTheme}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: 'Korolev',
                          decoration: TextDecoration.none,
                          color: AppColors.grey,
                          fontWeight: FontWeight.w700,
                          fontSize: SizeBlock.v! * 24),
                    )
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
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
                                        height: 1,
                                        fontFamily: 'KorolevCompressed',
                                        decoration: TextDecoration.none,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: SizeBlock.v! * 23)),
                              ),
                            ),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.top,
                              baseline: TextBaseline.alphabetic,
                              child: Transform.translate(
                                offset: const Offset(0.0, 0.0),
                                child: Text(
                                    '${(widget.gameModel.device!.currentCredits / 100).toStringAsFixed(2)}',
                                    style: TextStyle(
                                        height: 1,
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
                      if (widget.gameModel.device!.currentRestrictedAmount != 0.0)
                        RichText(
                          text: TextSpan(
                            children: <InlineSpan>[
                              WidgetSpan(
                                alignment: PlaceholderAlignment.top,
                                baseline: TextBaseline.alphabetic,
                                child: Transform.translate(
                                  offset: const Offset(0.0, 0.0),
                                  child: Text('Free Play ',
                                      style: TextStyle(
                                          height: 1,
                                          fontFamily: 'KorolevCompressed',
                                          decoration: TextDecoration.none,
                                          color: AppColors.redDarkText,
                                          fontWeight: FontWeight.w700,
                                          fontSize: SizeBlock.v! * 24)),
                                ),
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.top,
                                baseline: TextBaseline.alphabetic,
                                child: Transform.translate(
                                  offset: const Offset(0.0, 2.0),
                                  child: Text('\$',
                                      style: TextStyle(
                                          height: 1,
                                          fontFamily: 'KorolevCompressed',
                                          decoration: TextDecoration.none,
                                          color: AppColors.redDarkText,
                                          fontWeight: FontWeight.w700,
                                          fontSize: SizeBlock.v! * 14)),
                                ),
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.top,
                                baseline: TextBaseline.alphabetic,
                                child: Transform.translate(
                                  offset: const Offset(0.0, 0.0),
                                  child: Text(
                                      '${(widget.gameModel.device!.currentRestrictedAmount / 100).toStringAsFixed(2)}',
                                      style: TextStyle(
                                          height: 1,
                                          fontFamily: 'KorolevCompressed',
                                          decoration: TextDecoration.none,
                                          color: AppColors.redDarkText,
                                          fontWeight: FontWeight.w700,
                                          fontSize: SizeBlock.v! * 24)),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              Consumer<CashOutSlotsProvider>(
                builder: (BuildContext context,
                    CashOutSlotsProvider _myCashOutSlotsProvider,
                    Widget? child) {
                  if (_myCashOutSlotsProvider.expandedTileIndex ==
                      widget.tileIndex) {
                    return Column(
                      children: <Widget>[
                        SizedBox(
                          height: SizeBlock.v! * 12,
                        ),
                        CustomButton(
                          onTap: () async {
                            _gamesPlayingRowProvider!.cashOutAllFunds(context, gameModel: widget.gameModel);
                          },
                          text: 'CASH-OUT ALL FUNDS',
                          color: AppColors.redDark,
                          textStyle: TextStyle(
                              letterSpacing: SizeBlock.v! * 3,
                              color: AppColors.white,
                              fontSize: SizeBlock.v! * 20,
                              fontFamily: 'Korolev',
                              fontWeight: FontWeight.w800),
                        ),
                        if (widget.gameModel.allowPartialCashout as bool)
                        SizedBox(
                          height: SizeBlock.v! * 6,
                        ),
                        if (widget.gameModel.allowPartialCashout as bool)
                        Text(
                          '-OR-',
                          style: TextStyle(
                              color: AppColors.grey,
                              fontFamily: 'Korolev',
                              fontSize: SizeBlock.v! * 12,
                              fontWeight: FontWeight.w500),
                        ),
                        if (widget.gameModel.allowPartialCashout as bool)
                        SizedBox(
                          height: SizeBlock.v! * 6,
                        ),
                        if (widget.gameModel.allowPartialCashout as bool)
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
                        if (widget.gameModel.allowPartialCashout as bool)
                          SizedBox(
                          height: SizeBlock.v! * 12,
                        ),
                        if (widget.gameModel.allowPartialCashout as bool)
                          CustomButton(
                          onTap: () async {
                            _gamesPlayingRowProvider!.cashOutFunds(context, gameModel: widget.gameModel, priceEditingControllerText: _priceEditingController.text);
                          },
                          text: 'CASH-OUT FUNDS',
                          color: AppColors.grey,
                          textStyle: TextStyle(
                              letterSpacing: SizeBlock.v! * 3,
                              color: AppColors.white,
                              fontSize: SizeBlock.v! * 20,
                              fontFamily: 'Korolev',
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              )
            ],
          )),
    );
  }
}
