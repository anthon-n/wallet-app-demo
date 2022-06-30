import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/app-icons.dart';
import 'package:acresapp/common/helpers/app-images.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:acresapp/screens/fund_table_screens/fund_table_provider.dart';
import 'package:acresapp/services/bluetooth_service.dart';
import 'package:acresapp/widgets/universal_widgets/app-bar-widget.dart';
import 'package:acresapp/widgets/tables_and_slots_widgets/red_text_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class FundTableWaitForConfirmationScreen extends StatefulWidget {
  String serialNumber;
  int amount;
  String type;


  FundTableWaitForConfirmationScreen(this.serialNumber, this.amount, this.type);

  @override
  _FundTableWaitForConfirmationScreenState createState() => _FundTableWaitForConfirmationScreenState();
}

class _FundTableWaitForConfirmationScreenState extends State<FundTableWaitForConfirmationScreen> {
  BlueToothServiceProvider get blueToothService =>
      GetIt.instance<BlueToothServiceProvider>();
  FundTableProvider? _fundTableProvider;

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    _fundTableProvider = Provider.of<FundTableProvider>(context, listen: false);
    _fundTableProvider!.c2cConnectFunction(context, serialNumber: widget.serialNumber, type: widget.type, amt: widget.amount);
    super.initState();
  }


  @override
  void dispose() {
    _fundTableProvider!.c2cDisconnect(widget.serialNumber);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: AppColors.white,
        body: Stack(
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AppBarWidget(),
                SizedBox(height: SizeBlock.v! * 85,),
                Image.asset(
                  AppIcons.three_circle_bar,
                  width: SizeBlock.h! * 190,
                ),
                SizedBox(height: SizeBlock.v! * 25),
                RedTextCardWidgetTables('3. Fund Table Game',
                    'Wait for Confirmation\nfrom the Dealer'),
                SizedBox(height: SizeBlock.v! * 65),
                Image.asset(AppImages.fundTableImage,
                  height: SizeBlock.v! * 182,
                  width: SizeBlock.h! * 182,
                ),
              ],
            ),
          ],
        ));
  }
}
