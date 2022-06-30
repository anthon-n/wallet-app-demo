import 'package:acresapp/common/loaded_data.dart';
import 'package:acresapp/providers/home_page_provider.dart';
import 'package:acresapp/providers/home_tab_bar_provider.dart';
import 'package:acresapp/providers/name_provider.dart';
import 'package:acresapp/providers/tab_view_cash_out_fund_slots_provider.dart';
import 'package:acresapp/providers/timer_provider.dart';
import 'package:acresapp/screens/cash_out_slots_screens/select_screen/cash_out_slots_provider.dart';
import 'package:acresapp/screens/cash_out_table_screens/cash_out_table_provider.dart';
import 'package:acresapp/screens/fund_slots_screens/fund_slots_scan_screen.dart';
import 'package:acresapp/screens/fund_slots_screens/select_screen/fund_slots_provider.dart';
import 'package:acresapp/screens/fund_table_screens/fund_table_game_select/fund_table_game_select_provider.dart';
import 'package:acresapp/screens/fund_table_screens/fund_table_provider.dart';
import 'package:acresapp/screens/fund_table_screens/fund_table_transfer/fund_table_transfer_provider.dart';
import 'package:acresapp/screens/home/home.screen.dart';
import 'package:acresapp/screens/home/home_main_view.dart';
import 'package:acresapp/screens/scan_screens/scan_machine_cash_out_screen/scan_machine_cash_out_provider.dart';
import 'package:acresapp/screens/scan_screens/scan_machine_fund_screen/scan_machine_fund_provider.dart';
import 'package:acresapp/services/bluetooth_service.dart';
import 'package:acresapp/services/device_service.dart';
import 'package:acresapp/services/flutter_blue_service.dart';
import 'package:acresapp/services/game_service.dart';
import 'package:acresapp/services/reset_service.dart';
import 'package:acresapp/services/tapometer_service.dart';
import 'package:acresapp/services/tables_slot_service.dart';
import 'package:acresapp/services/wallet_service.dart';
import 'package:acresapp/widgets/home_page_widgets/tapometer_widget/tapometer_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/helpers/size_block.dart';

void setupLocator() {
  GetIt.instance.registerLazySingleton(() => DeviceService());
  GetIt.instance.registerLazySingleton(() => WalletService());
  GetIt.instance.registerLazySingleton(() => TablesSlotService());
  GetIt.instance.registerLazySingleton(() => BlueToothServiceProvider());
  GetIt.instance.registerLazySingleton(() => GameService());
  GetIt.instance.registerLazySingleton(() => TapometerService());
  GetIt.instance.registerLazySingleton(() => ResetService());
  GetIt.instance.registerLazySingleton(() => FlutterBlueService());
}


//todo Bluetooth Service Disconnect Function causes exceptions when called
//todo make keyboard scroll to an appropriate position and not make the whole page scroll
//todo edit the code structure make all the logic go into provider filed

DeviceService get deviceService => GetIt.instance<DeviceService>();


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String? tempUserName = _prefs.getString("user_name");
  String? tempHostName = _prefs.getString("host_name");
  tempHostName ??= '';
  tempUserName ??= '';
  setupLocator();
  runApp(MediaQuery(
      data: const MediaQueryData(), child: MyApp(tempUserName, tempHostName)));
}

class MyApp extends StatelessWidget {
  String? userName;
  String? hostName;

  MyApp(this.userName, this.hostName);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);

    SystemChrome.setEnabledSystemUIOverlays(
        <SystemUiOverlay>[SystemUiOverlay.bottom]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TabViewCashOutFundSlotsProvider>(
          create: (BuildContext context) => TabViewCashOutFundSlotsProvider(),
        ),
        ChangeNotifierProvider<NamesProvider>(
          create: (BuildContext context) => NamesProvider(userName!, hostName!),
        ),
        ChangeNotifierProvider<FundSlotsProvider>(
          create: (BuildContext context) => FundSlotsProvider(),
        ),
        ChangeNotifierProvider<CashOutSlotsProvider>(
          create: (BuildContext context) => CashOutSlotsProvider(),
        ),
        ChangeNotifierProvider<FundTableGameSelectProvider>(
          create: (BuildContext context) => FundTableGameSelectProvider(),
        ),
        ChangeNotifierProvider<HomePageProvider>(
          create: (BuildContext context) =>
              HomePageProvider(const HomeScreen(), "HOME"),
        ),
        ChangeNotifierProvider<HomeTabBarProvider>(
          create: (BuildContext context) => HomeTabBarProvider(),
        ),
        ChangeNotifierProvider<LoadedDataProvider>(
          create: (BuildContext context) => LoadedDataProvider(),
        ),
        ChangeNotifierProvider<BlueToothServiceProvider>(
          create: (BuildContext context) => BlueToothServiceProvider(),
        ),
        ChangeNotifierProvider<TimerProvider>(
          create: (BuildContext context) => TimerProvider(),
        ),
        ChangeNotifierProvider<FundTableProvider>(
          create: (BuildContext context) => FundTableProvider(),
        ),
        ChangeNotifierProvider<CashOutTableProvider>(
          create: (BuildContext context) => CashOutTableProvider(),
        ),
        ChangeNotifierProvider<ScanMachineFundProvider>(
          create: (BuildContext context) => ScanMachineFundProvider(),
        ),
        ChangeNotifierProvider<ScanMachineCashOutProvider>(
          create: (BuildContext context) => ScanMachineCashOutProvider(),
        ),
        ChangeNotifierProvider<FundTableTransferProvider>(
          create: (BuildContext context) => FundTableTransferProvider(),
        ),

      ],
      child: MaterialApp(
        builder: (BuildContext context, Widget? child) {
          SizeBlock().init(context);
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
              child: child!);
        },
        debugShowCheckedModeBanner: false,
        title: '',
        theme: ThemeData(
          fontFamily: 'MostraNuova',
        ),
        initialRoute: '/home',
        routes: {
          '/home': (BuildContext context) => HomeMainView(),
          '/fund_slots': (BuildContext context) => FundSlotsScanScreen(),
        },
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
