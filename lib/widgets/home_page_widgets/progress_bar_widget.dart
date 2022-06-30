import 'package:acresapp/common/helpers/app-images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProgressBarWidget extends StatelessWidget {
  ProgressBarWidget(this.completeness);
  int completeness;
  @override
  Widget build(BuildContext context) {
    switch (completeness) {
      case 10: return SvgPicture.asset(AppImages.tenPercentProgressBar, fit: BoxFit.fill,);
      case 20: return SvgPicture.asset(AppImages.twentyPercentProgressBar, fit: BoxFit.fill,);
      case 30: return SvgPicture.asset(AppImages.thirtyPercentProgressBar, fit: BoxFit.fill,);
      case 40: return SvgPicture.asset(AppImages.fortyPercentProgressBar, fit: BoxFit.fill,);
      case 50: return SvgPicture.asset(AppImages.fiftyPercentProgressBar, fit: BoxFit.fill,);
      case 60: return SvgPicture.asset(AppImages.sixtyPercentProgressBar, fit: BoxFit.fill,);
      case 70: return SvgPicture.asset(AppImages.seventyPercentProgressBar, fit: BoxFit.fill,);
      case 80: return SvgPicture.asset(AppImages.eightPercentProgressBar, fit: BoxFit.fill,);
      case 90: return SvgPicture.asset(AppImages.ninetyPercentProgressBar, fit: BoxFit.fill,);
      case 100: return SvgPicture.asset(AppImages.hundredPercentProgressBar, fit: BoxFit.fill,);
    }
    return SvgPicture.asset(AppImages.zeroPercentProgressBar, fit: BoxFit.fill,);
  }
}