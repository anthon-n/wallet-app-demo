import 'dart:async';
import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/app-icons.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:acresapp/common/loaded_data.dart';
import 'package:acresapp/models/device_model.dart';
import 'package:acresapp/models/wallet_model.dart';
import 'package:acresapp/providers/timer_provider.dart';
import 'package:acresapp/screens/fund_slots_screens/select_screen/fund_slots_provider.dart';
import 'package:acresapp/services/wallet_service.dart';
import 'package:acresapp/widgets/universal_widgets/build_divider.dart';
import 'package:acresapp/widgets/tables_and_slots_widgets/red_text_card_widget.dart';
import 'package:acresapp/widgets/universal_widgets/bottom-navigation-bar.widget.dart';
import 'package:acresapp/widgets/universal_widgets/custom_button.dart';
import 'package:acresapp/widgets/universal_widgets/loading_indicator.dart';
import 'package:acresapp/widgets/wallet_widgets/wallet_row/wallet_row_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class FundSlotsView extends StatefulWidget {
  DeviceModel deviceModel;
  FundSlotsView(this.deviceModel);

  @override
  _FundSlotsViewState createState() => _FundSlotsViewState();
}

class _FundSlotsViewState extends State<FundSlotsView> {
  FundSlotsProvider? _fundSlotsProvider;
  final ScrollController scrollController = ScrollController();
  WalletService get walletService => GetIt.instance<WalletService>();

  StreamController<List<dynamic>> _fundSlotsController = StreamController();


  Timer? _timer;


  TimerProvider? timerProvider;
  @override
  void initState() {
    timerProvider = Provider.of<TimerProvider>(context, listen: false);
    _fundSlotsProvider = Provider.of<FundSlotsProvider>(context, listen: false);
    _fundSlotsProvider!.loadWallets(context);
    _timer = Timer.periodic(
        const Duration(milliseconds: 1000), (_) => _fundSlotsProvider!.loadWallets(context));
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    scrollController.dispose();
    _fundSlotsProvider!.clearExpandedTiles();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LoadedDataProvider loadedDataProvider = Provider.of<LoadedDataProvider>(context, listen: false);
    return Column(
      children: <Widget>[
        Consumer<FundSlotsProvider>(
          builder: (BuildContext context,
              FundSlotsProvider _myFundSlotsProvider, Widget? child) {
            return Image.asset(
              (_myFundSlotsProvider.expandedTileIndex == -1)
                  ? AppIcons.two_circle_bar
                  : AppIcons.three_circle_bar,
              width: SizeBlock.h! * 190,
            );
          },
        ),
        SizedBox(
          height: SizeBlock.h! * 25,
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Consumer<FundSlotsProvider>(
                builder: (BuildContext context,
                    FundSlotsProvider _myFundSlotsProvider, Widget? child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      (_myFundSlotsProvider.expandedTileIndex == -1)
                          ? RedTextCardWidgetSlots(
                              '2. Fund Slots', 'Select Which Currency.')
                          : RedTextCardWidgetSlots(
                              '3. Fund Slots', 'Enter the amount.'),
                      // Spacer(),
                      Row(
                        children: <Widget>[
                          buildIconWithTextVertical(AppIcons.timer, 'TIMER'),
                          SizedBox(width: SizeBlock.h! * 10),
                          Consumer<TimerProvider>(
                            builder: (BuildContext context, TimerProvider _myTimerProvider, Widget? child) {
                              if (_myTimerProvider.secondsLeft <= 0) {
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
                  );
                },
              ),
              SizedBox(
                height: SizeBlock.v! * 20,
              ),
              buildDivider(),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: EdgeInsets.only(bottom: SizeBlock.v! * 30),
                  child: Column(
                    children: [
                      StreamBuilder<Object>(
                          stream: _fundSlotsController.stream,
                          initialData:
                              (loadedDataProvider.loadedWallets.isEmpty) ? null : loadedDataProvider.loadedWallets,
                          builder:
                              (BuildContext context, streamBuilderSnapshot) {
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
                              int i = 0;
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: (data as List).length,
                                itemBuilder: (BuildContext context, int index) {
                                  dynamic val = data[index];
                                  return Column(
                                    children: <Widget>[
                                      WalletRowWidget(
                                        WalletModel.fromMap(
                                            val as Map<String, dynamic>),
                                        i++,
                                        scrollController,
                                      ),
                                      buildDivider(),
                                    ],
                                  );
                                },
                              );
                            } else {
                              return Container();
                            }
                          }),
                      SizedBox(
                        height: SizeBlock.v! * 30,
                      ),
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
                            _fundSlotsProvider!.clearExpandedTiles();
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
                ),
              ),
              // buildDivider(),
            ],
          ),
        ),
      ],
    );
  }
}
