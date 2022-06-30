import 'dart:async';
import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:acresapp/common/loaded_data.dart';
import 'package:acresapp/models/wallet_model.dart';
import 'package:acresapp/screens/fund_slots_screens/select_screen/fund_slots_provider.dart';
import 'package:acresapp/services/wallet_service.dart';
import 'package:acresapp/widgets/home_page_widgets/home_page_wallet_row.dart';
import 'package:acresapp/widgets/universal_widgets/build_divider.dart';
import 'package:acresapp/widgets/universal_widgets/custom_button.dart';
import 'package:acresapp/widgets/universal_widgets/loading_indicator.dart';
import 'package:acresapp/widgets/wallet_widgets/wallet_row/wallet_row_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'home_wallet_items_provider.dart';

class HomeWalletItems extends StatefulWidget {
  @override
  _HomeWalletItemsState createState() => _HomeWalletItemsState();
}

class _HomeWalletItemsState extends State<HomeWalletItems> {
  HomeWalletItemsProvider? _homeWalletItemsProvider;

  Timer? _timer;

  @override
  void initState() {
    _homeWalletItemsProvider = Provider.of<HomeWalletItemsProvider>(context, listen: false);
    _homeWalletItemsProvider!.loadWallets(context);
    _timer = Timer.periodic(
        const Duration(milliseconds: 1000), (_) => _homeWalletItemsProvider!.loadWallets(context));
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
    return Column(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: SizeBlock.v! * 50,
              ),
              buildDivider(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: SizeBlock.v! * 30),
                  child: Column(
                    children: [
                      StreamBuilder<Object>(
                          stream: _homeWalletItemsProvider!.fundSlotsController.stream,
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
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: (data as List).length,
                                itemBuilder: (BuildContext context, int index) {
                                  dynamic val = data[index];
                                  return Column(
                                    children: <Widget>[
                                      HomePageWalletRowWidget(
                                        WalletModel.fromMap(
                                            val as Map<String, dynamic>),
                                        i++,
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
