import 'package:acresapp/common/helpers/app-images.dart';
import 'package:acresapp/services/tapometer_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class TapometerProvider with ChangeNotifier {
  bool isScratchometerComplete = false;
  int pointsComplete = 0;
  bool isBonusRevealed = false;
  dynamic amount = 0;

  TapometerService? get scratchometerService =>
      GetIt.instance<TapometerService>();
  AssetImage? appropriateImage = const AssetImage(AppImages.fiveDollarFreeSlot);


  void getScratchometerInformation(BuildContext context) async {
    dynamic requestResult =
    await scratchometerService!.getTapometerProgress(context);
    if (requestResult != null) {
        isScratchometerComplete = requestResult['is_complete'] as bool;
        pointsComplete = requestResult['pct_complete'] as int;
        notifyListeners();
    }
  }

  void revealBonus() {
    isBonusRevealed = true;
    notifyListeners();
  }

  void hideBonus() {
    isBonusRevealed = false;
    pointsComplete = 0;
    notifyListeners();
  }

  void showAppropriateImage(BuildContext context) async {
    dynamic result = await scratchometerService!
        .redeemTapometerBonus(context);
    if (result == '5000') {
      appropriateImage =
      const AssetImage(AppImages.fiftyDollarFreeSlot);
    } else if (result == '1000') {
      appropriateImage =
      const AssetImage(AppImages.tenDollarFreeSlot);
    } else {
      appropriateImage =
      const AssetImage(AppImages.fiveDollarFreeSlot);
    }
  }


}