import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:acresapp/models/game_model.dart';
import 'package:acresapp/screens/cash_out_slots_screens/select_screen/cash_out_slots_provider.dart';
import 'package:acresapp/screens/cash_out_slots_screens/transfer_complete_cash_out_slots.dart';
import 'package:acresapp/services/game_service.dart';
import 'package:acresapp/widgets/games_playing_widgets/letter_game_container_widget.dart';
import 'package:acresapp/widgets/universal_widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:provider/provider.dart';

class HomePageGameRowWidget extends StatefulWidget {
  GameModel gameModel;
  Color color;
  int tileIndex;

  HomePageGameRowWidget({
    required this.gameModel,
    required this.tileIndex,
    required this.color,
  });

  @override
  _HomePageGameRowWidgetState createState() => _HomePageGameRowWidgetState();
}

class _HomePageGameRowWidgetState extends State<HomePageGameRowWidget> {
  bool isExpanded = false;

  GameService get gameService => GetIt.instance<GameService>();
  TextEditingController _priceEditingController = TextEditingController();

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
                      ('${widget.gameModel.device!.gameTheme}'.length > 0) ? '${widget.gameModel.device!.gameTheme[0]}' : ''
                      , widget.color),
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
                    ),
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
            ],
          )),
    );
  }

}
