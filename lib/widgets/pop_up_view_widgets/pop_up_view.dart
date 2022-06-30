import 'package:acresapp/common/helpers/app-icons.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:acresapp/screens/cash_out_slots_screens/select_screen/cash_out_slots_provider.dart';
import 'package:acresapp/screens/fund_slots_screens/select_screen/fund_slots_provider.dart';
import 'package:acresapp/screens/scan_screens/scan_machine_cash_out_screen/scan_machine_cash_out_screen.dart';
import 'package:acresapp/screens/scan_screens/scan_machine_fund_screen/scan_machine_fund_screen.dart';
import 'package:acresapp/widgets/pop_up_view_widgets/pop_up_view_column_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showPopUpWidget(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        height: SizeBlock.h! * 272,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(SizeBlock.v! * 50.0),
                  topRight: Radius.circular(SizeBlock.v! * 50.0))),
          width: double.infinity,
          height: SizeBlock.v! * 272,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                 // Navigator.push<dynamic>(context, MaterialPageRoute<dynamic>(builder: (context) => FundSlotsTransferScreen()));
                  Navigator.push<dynamic>(context, MaterialPageRoute<dynamic>(builder: (context) => ScanMachineFundScreen()));
                },
                  child: buildPopUpViewColumn('Fund', 'Add Money to Your Game', AppIcons.arrow_up)),
              //SizedBox(width: SizeBlock.h! * 30,),
              GestureDetector(
                  onTap: () {
                    final CashOutSlotsProvider _cashOutSlotsProvider = Provider.of<CashOutSlotsProvider>(context, listen: false);
                    final FundSlotsProvider _fundSlotsProvider = Provider.of<FundSlotsProvider>(context, listen: false);
                    _cashOutSlotsProvider.clearExpandedTiles();
                    _fundSlotsProvider.clearExpandedTiles();
                    Navigator.pop(context);
                    Navigator.push<dynamic>(context, MaterialPageRoute<dynamic>(builder: (context) => ScanMachineCashOutScreen()));
                  },
                  child: buildPopUpViewColumn('Cash-Out', 'Put Money Back to Your Wallet', AppIcons.arrow_down))
            ],
          ),
        ),
      );
    },
  );
}
