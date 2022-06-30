import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/app-images.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:acresapp/models/device_model.dart';
import 'package:acresapp/providers/tab_view_cash_out_fund_slots_provider.dart';
import 'package:acresapp/providers/timer_provider.dart';
import 'package:acresapp/screens/cash_out_table_screens/cash_out_table_screen_you_are_connected.dart';
import 'package:acresapp/screens/main_tab_view_cash_out_fund_slots.dart';
import 'package:acresapp/screens/scan_screens/scan_machine_cash_out_screen/scan_machine_cash_out_provider.dart';
import 'package:acresapp/services/bluetooth_service.dart';
import 'package:acresapp/services/device_service.dart';
import 'package:acresapp/widgets/universal_widgets/alert_pop_up.dart';
import 'package:acresapp/widgets/universal_widgets/app-bar-widget.dart';
import 'package:acresapp/widgets/tables_and_slots_widgets/red_text_card_widget.dart';
import 'package:acresapp/widgets/universal_widgets/custom_button.dart';
import 'package:acresapp/widgets/universal_widgets/show_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';


class ScanMachineCashOutScreen extends StatefulWidget {
  @override
  _ScanMachineCashOutScreenState createState() => _ScanMachineCashOutScreenState();
}

class _ScanMachineCashOutScreenState extends State<ScanMachineCashOutScreen> {


  DeviceService get deviceService => GetIt.instance<DeviceService>();
  ScanMachineCashOutProvider? _scanMachineCashOutProvider;



  @override
  void initState() {
    super.initState();
    _scanMachineCashOutProvider = Provider.of<ScanMachineCashOutProvider>(context, listen: false);
    _scanMachineCashOutProvider!.getNearestDeviceSerialNumber(context);
  }

  @override
  void dispose() {
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
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: SizeBlock.v! * 150),
                        const SizedBox(height: 25),
                        RedTextCardWidgetTables('Locating...',
                            'Hold your device close\nto your game'),
                        SizedBox(height: SizeBlock.v! * 40),
                        // SvgPicture.asset(AppIcons.mt),
                        Image.asset(
                          AppImages.connect,
                          height: SizeBlock.v! * 226,
                        ),
                        SizedBox(height: SizeBlock.v! * 40,),
                        Container(
                          margin:
                          EdgeInsets.symmetric(horizontal: SizeBlock.h! * 50),
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(SizeBlock.v! * 10),
                              border: Border.all(color: AppColors.grey)),
                          child: CustomButton(
                            onTap: () {
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
              ],
            ),
          ],
        ));
  }
}
