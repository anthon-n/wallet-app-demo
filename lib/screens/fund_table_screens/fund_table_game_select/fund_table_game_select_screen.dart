import 'dart:async';
import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/app-icons.dart';
import 'package:acresapp/common/helpers/app-images.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:acresapp/common/loaded_data.dart';
import 'package:acresapp/models/wallet_model.dart';
import 'package:acresapp/services/wallet_service.dart';
import 'package:acresapp/widgets/fund_table_widgets/fund_table_row/fund_table_row_provider.dart';
import 'package:acresapp/widgets/universal_widgets/build_divider.dart';
import 'package:acresapp/widgets/universal_widgets/app-bar-widget.dart';
import 'package:acresapp/widgets/universal_widgets/custom_button.dart';
import 'package:acresapp/widgets/fund_table_widgets/fund_table_row/fund_table_row_widget.dart';
import 'package:acresapp/widgets/tables_and_slots_widgets/red_text_card_widget.dart';
import 'package:acresapp/widgets/universal_widgets/loading_indicator.dart';
import 'package:acresapp/widgets/wallet_widgets/wallet_row/wallet_row_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'fund_table_game_select_provider.dart';

class FundTableGameSelectScreen extends StatefulWidget {
  String serialNumber;

  FundTableGameSelectScreen(this.serialNumber);

  @override
  _FundTableGameSelectScreenState createState() =>
      _FundTableGameSelectScreenState();
}

class _FundTableGameSelectScreenState extends State<FundTableGameSelectScreen> {
  FundTableGameSelectProvider? _fundTableGameSelectProvider;
  WalletService get walletService => GetIt.instance<WalletService>();
  Timer? _timer;

  @override
  void initState() {
    _fundTableGameSelectProvider =
        Provider.of<FundTableGameSelectProvider>(context, listen: false);
    _fundTableGameSelectProvider!.loadWallets(context);
    _timer = Timer.periodic(const Duration(milliseconds: 1000),
        (_) => _fundTableGameSelectProvider!.loadWallets(context));
    super.initState();
  }


  @override
  void dispose() {
    _timer!.cancel();
    _fundTableGameSelectProvider!.clearExpandedTiles();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LoadedDataProvider loadedDataProvider =
        Provider.of<LoadedDataProvider>(context, listen: false);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WalletRowProvider>(
          create: (BuildContext context) => WalletRowProvider(),
        ),
        ChangeNotifierProvider<FundTableGameSelectProvider>(
          create: (BuildContext context) => FundTableGameSelectProvider(),
        ),
        ChangeNotifierProvider<FundTableRowProvider>(
          create: (BuildContext context) => FundTableRowProvider(),
        ),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            reverse: true,
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
              child: Stack(
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
                      SizedBox(height: SizeBlock.v! * 100),
                      Container(
                        alignment: Alignment.center,
                        child: Consumer<FundTableGameSelectProvider>(
                          builder: (BuildContext context,
                              _fundTableGameSelectProvider, Widget? child) {
                            return Image.asset(
                              (_fundTableGameSelectProvider.expandedTileIndex ==
                                      -1)
                                  ? AppIcons.one_circle_bar
                                  : AppIcons.two_circle_bar,
                              width: SizeBlock.h! * 190,
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: SizeBlock.h! * 25,
                      ),
                      Consumer<FundTableGameSelectProvider>(
                        builder: (BuildContext context,
                            _fundTableGameSelectProvider, Widget? child) {
                          return (_fundTableGameSelectProvider
                                      .expandedTileIndex ==
                                  -1)
                              ? RedTextCardWidgetTables('1. Fund Table Game',
                                  'Select which currency.')
                              : RedTextCardWidgetTables(
                                  '2. Fund Table Game', 'Enter the amount.');
                        },
                      ),
                      SizedBox(
                        height: SizeBlock.v! * 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: SizeBlock.h! * 20,
                          right: SizeBlock.h! * 20,
                        ),
                        child: buildDivider(),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            StreamBuilder<Object>(
                                stream: _fundTableGameSelectProvider!
                                    .fundTablesController.stream,
                                initialData:
                                    (loadedDataProvider.loadedWallets.isEmpty)
                                        ? null
                                        : loadedDataProvider.loadedWallets,
                                builder: (BuildContext context,
                                    streamBuilderSnapshot) {
                                  if (!streamBuilderSnapshot.hasData) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: SizeBlock.v! * 25),
                                          child: CustomLoadingIndicator(),
                                        ),
                                      ],
                                    );
                                  } else if (streamBuilderSnapshot.hasData &&
                                      !streamBuilderSnapshot.hasError) {
                                    dynamic data = streamBuilderSnapshot.data;
                                    int i = 0;
                                    return ListView.builder(
                                      padding: EdgeInsets.only(
                                        bottom: SizeBlock.v! * 20,
                                        left: SizeBlock.h! * 20,
                                        right: SizeBlock.h! * 20,
                                      ),
                                      shrinkWrap: true,
                                      itemCount: (data as List).length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        dynamic val = data[index];
                                        if (val['type'] == 0 ||
                                            val['type'] == 1) {
                                          if (val['name'] == 'Free Play') {
                                            val['name'] = 'Promo Chips';
                                          }
                                          return Column(
                                            children: <Widget>[
                                              FundTableRowWidget(
                                                  WalletModel.fromMap(val
                                                      as Map<String, dynamic>),
                                                  i++,
                                                  widget.serialNumber),
                                              buildDivider(),
                                            ],
                                          );
                                        }
                                        return Container();
                                      },
                                    );
                                  } else {
                                    return Container();
                                  }
                                }),
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: SizeBlock.h! * 50,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(SizeBlock.v! * 10),
                                  border: Border.all(color: AppColors.grey)),
                              child: CustomButton(
                                onTap: () {
                                  _fundTableGameSelectProvider!
                                      .clearExpandedTiles();
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
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
