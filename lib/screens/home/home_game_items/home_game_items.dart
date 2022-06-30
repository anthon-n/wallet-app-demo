import 'dart:async';
import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:acresapp/common/loaded_data.dart';
import 'package:acresapp/models/game_model.dart';
import 'package:acresapp/screens/cash_out_slots_screens/select_screen/cash_out_slots_provider.dart';
import 'package:acresapp/screens/home/home_game_items/home_game_items_provider.dart';
import 'package:acresapp/widgets/home_page_widgets/home_page_game_row.dart';
import 'package:acresapp/widgets/universal_widgets/build_divider.dart';
import 'package:acresapp/widgets/universal_widgets/loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeGameItems extends StatefulWidget {
  @override
  _HomeGameItemsState createState() => _HomeGameItemsState();
}

class _HomeGameItemsState extends State<HomeGameItems> {

  HomeGameItemsProvider? _homeGameItemsProvider;

  Timer? _timer;


  @override
  void initState() {
    _homeGameItemsProvider = Provider.of<HomeGameItemsProvider>(context, listen: false);
    _homeGameItemsProvider!.loadGames(context);
    _timer =
        Timer.periodic(const Duration(milliseconds: 1000), (_) => _homeGameItemsProvider!.loadGames(context));
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LoadedDataProvider loadedDataProvider = Provider.of<LoadedDataProvider>(context, listen: false);
    return Consumer<CashOutSlotsProvider>(
      builder: (BuildContext context,
          CashOutSlotsProvider _myCashOutSlotsProvider, Widget? child) {
        return Padding(
          padding: EdgeInsets.only(top: SizeBlock.v! * 120),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Games',
                    style: TextStyle(
                        color: AppColors.grey,
                        fontSize: SizeBlock.v! * 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Korolev'),
                  ),
                  const Spacer(),
                  Text(
                    'Credits',
                    style: TextStyle(
                        color: AppColors.grey,
                        fontSize: SizeBlock.v! * 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Korolev'),
                  ),
                ],
              ),
              buildDivider(),
              Expanded(
                  child: StreamBuilder<Object>(
                      stream: _homeGameItemsProvider!.cashOutSlotsController.stream,
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
                              print(val);
                              return Column(
                                children: <Widget>[
                                  HomePageGameRowWidget(
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
