import 'dart:async';
import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/app-icons.dart';
import 'package:acresapp/common/helpers/app-images.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:acresapp/common/loaded_data.dart';
import 'package:acresapp/models/device_model.dart';
import 'package:acresapp/models/game_model.dart';
import 'package:acresapp/screens/cash_out_slots_screens/select_screen/cash_out_slots_provider.dart';
import 'package:acresapp/widgets/games_playing_widgets/games_playing_row/games_playing_row.dart';
import 'package:acresapp/widgets/universal_widgets/build_divider.dart';
import 'package:acresapp/widgets/universal_widgets/loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CashOutSlotsView extends StatefulWidget {
  DeviceModel? deviceModel;
  CashOutSlotsView(this.deviceModel);
  @override
  _CashOutSlotsViewState createState() => _CashOutSlotsViewState();
}

class _CashOutSlotsViewState extends State<CashOutSlotsView> {
  CashOutSlotsProvider? _cashOutSlotsProvider;


  Timer? _timer;

  @override
  void initState() {
    _cashOutSlotsProvider = Provider.of<CashOutSlotsProvider>(context, listen: false);
    _cashOutSlotsProvider!.loadGames(context);
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (_) => _cashOutSlotsProvider!.loadGames(context));
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    _cashOutSlotsProvider!.clearExpandedTiles();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LoadedDataProvider loadedDataProvider = Provider.of<LoadedDataProvider>(context, listen: false);
    return Consumer<CashOutSlotsProvider>(
      builder: (BuildContext context,
          CashOutSlotsProvider _myCashOutSlotsProvider, Widget? child) {
        return Padding(
          padding: (_myCashOutSlotsProvider.expandedTileIndex == -1)
              ? EdgeInsets.only(top: SizeBlock.v! * 70)
              : EdgeInsets.only(top: SizeBlock.v! * 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                  SizedBox(width: SizeBlock.h! * 10),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                      CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                           '${widget.deviceModel!.gameTheme}',
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
              SizedBox(height: SizeBlock.v! * 25),
              buildDivider(),
              Expanded(
                  child: StreamBuilder<Object>(
                      stream: _myCashOutSlotsProvider.cashOutSlotsController.stream,
                      initialData: (loadedDataProvider.loadedGames.isEmpty) ? null : loadedDataProvider.loadedGames,
                      builder: (BuildContext context, streamBuilderSnapshot) {
                        if (!streamBuilderSnapshot.hasData) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(top: SizeBlock.v! * 25),
                                child: CustomLoadingIndicator(),
                              ),
                            ],
                          );
                        } else if (streamBuilderSnapshot.hasData &&
                            !streamBuilderSnapshot.hasError) {
                          dynamic data = streamBuilderSnapshot.data;
                          dynamic keys = data.keys.toList();
                          int i = 0;
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: (keys as List).length,
                            itemBuilder: (BuildContext context, int index) {
                              dynamic val = data[keys[index]];
                              return Column(
                                children: <Widget>[
                                  GamesPlayingRowWidget(
                                    gameModel: GameModel.fromMap(
                                        val as Map<String, dynamic>),
                                    tileIndex: i++,
                                    color: Colors.blue,
                                  ),
                                  buildDivider(),
                                ],
                              );
                            },
                          );
                        } else {
                          return Container();
                        }
                      })
                  )
            ],
          ),
        );
      },
    );
  }
}
