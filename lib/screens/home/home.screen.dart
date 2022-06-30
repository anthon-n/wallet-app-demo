import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/app-images.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:acresapp/providers/name_provider.dart';
import 'package:acresapp/screens/scan_screens/scan_machine_fund_screen/scan_machine_fund_provider.dart';
import 'package:acresapp/services/bluetooth_service.dart';
import 'package:acresapp/services/device_service.dart';
import 'package:acresapp/services/flutter_blue_service.dart';
import 'package:acresapp/widgets/home_page_widgets/tapometer_widget/tapometer_provider.dart';
import 'package:acresapp/widgets/home_page_widgets/tapometer_widget/tapometer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  
  const HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DeviceService get deviceService => GetIt.instance<DeviceService>();

  BlueToothServiceProvider get blueToothService =>
      GetIt.instance<BlueToothServiceProvider>();

  FlutterBlueService get flutterBlueService =>
      GetIt.instance<FlutterBlueService>();

  bool isBonusRevealed = false;
  String status = 'PLATINUM REWARDS MEMBER';

  @override
  initState() {
    super.initState();
    blueToothService.init();
    flutterBlueService.init();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TapometerProvider>(
          create: (BuildContext context) => TapometerProvider(),
        ),
      ],
      child: Container(
            padding: EdgeInsets.only(top: SizeBlock.v! * 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppImages.platinumMemberBadgeIcon,
                    width: SizeBlock.h! * 35,
                    fit: BoxFit.fill,
                  ),
                  Column(
                    children: [
                      Container(
                          child: Consumer<NamesProvider>(
                            builder: (BuildContext context, _namesProvider, Widget? child) {
                              return Text('WELCOME ${_namesProvider.userName}'.toUpperCase(),
                                  style: TextStyle(
                                      fontFamily: 'MostraNuova',
                                      decoration: TextDecoration.none,
                                      fontSize: SizeBlock.v! * 20,
                                      color: AppColors.greenishGrey,
                                      fontWeight: FontWeight.w700));
                            },
                          )),
                      Container(
                          child: Text('$status',
                              style: TextStyle(
                                  fontFamily: 'Korolev',
                                  decoration: TextDecoration.none,
                                  fontSize: SizeBlock.v! * 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal))),
                    ],
                  ),
                ],
              ),

              SizedBox(
                height: SizeBlock.v! * 15,
              ),
              TapometerWidget(),
              SizedBox(
                height: SizeBlock.v! * 20,
              ),
              const Spacer(),
              // Container(child: const BottomNavigationBarWidget())
            ])),
    );
  }
}
