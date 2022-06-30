import 'dart:async';
import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/app-icons.dart';
import 'package:acresapp/common/helpers/app-images.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:acresapp/services/tapometer_service.dart';
import 'package:acresapp/widgets/home_page_widgets/progress_bar_widget.dart';
import 'package:acresapp/widgets/home_page_widgets/tapometer_widget/tapometer_provider.dart';
import 'package:acresapp/widgets/home_page_widgets/wrapper-block-radius.widget.dart';
import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class TapometerWidget extends StatefulWidget {
  @override
  _TapometerWidgetState createState() => _TapometerWidgetState();
}

class _TapometerWidgetState extends State<TapometerWidget>
    with SingleTickerProviderStateMixin {
  TapometerService? get scratchometerService =>
      GetIt.instance<TapometerService>();
  TapometerProvider? _tapometerProvider;

  Timer? _timer;

  @override
  void initState() {
    _tapometerProvider = Provider.of<TapometerProvider>(context, listen: false);
    _tapometerProvider!.getScratchometerInformation(context);
    _timer = Timer.periodic(
        const Duration(milliseconds: 1500),
        (_) => _tapometerProvider!.getScratchometerInformation(
              context,
            ));
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TapometerProvider>(
      builder: (BuildContext context, TapometerProvider myTapometerProvider, Widget? child) {
        return Column(
          children: [
            WrapperBlockRadiusWidget(
              GestureDetector(
                onTap: () async {
                  if (myTapometerProvider.isBonusRevealed) {
                    _tapometerProvider!.hideBonus();
                  } else if (myTapometerProvider.pointsComplete == 100 && !myTapometerProvider.isBonusRevealed) {
                    _tapometerProvider!.showAppropriateImage(context);
                    _tapometerProvider!.revealBonus();
                  }
                },
                child: Container(
                    height: SizeBlock.v! * 440,
                    width: SizeBlock.h! * 305,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          image: !myTapometerProvider.isBonusRevealed
                              ? const AssetImage(
                                  AppImages.tapAndWin,
                                )
                              : myTapometerProvider.appropriateImage!,
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(SizeBlock.v! * 60)),
                    child: Container(
                      width: SizeBlock.h! * 250,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            if (!myTapometerProvider.isBonusRevealed && myTapometerProvider.pointsComplete != 100)
                              Container(
                                width: SizeBlock.v! * 60,
                                height: SizeBlock.v! * 60,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          offset: const Offset(0, 5),
                                          blurRadius: SizeBlock.v! * 40,
                                          color: Colors.black.withOpacity(0.5))
                                    ],
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(
                                        SizeBlock.v! * 100),
                                    border: Border.all(
                                        width: SizeBlock.v! * 5,
                                        color: Colors.white)),
                                child: SvgPicture.asset(AppIcons.castle,
                                    height: SizeBlock.v! * 24,
                                    width: SizeBlock.v! * 24),
                              ),
                            SizedBox(height: SizeBlock.v! * 20),
                            if (myTapometerProvider.pointsComplete == 100 && !myTapometerProvider.isBonusRevealed)
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: SizeBlock.v! * 10),
                                child: Text(
                                  'Tap to Unlock Bonus',
                                  style: TextStyle(
                                      fontSize: SizeBlock.v! * 18,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Korolev'),
                                ),
                              ),
                            !myTapometerProvider.isBonusRevealed
                                ? Container(
                                    width: SizeBlock.h! * 250,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'TAP-O-METER',
                                          style: TextStyle(
                                              fontFamily: 'Korolev',
                                              fontStyle: FontStyle.normal,
                                              decoration: TextDecoration.none,
                                              fontSize: SizeBlock.v! * 10,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          '${(myTapometerProvider.pointsComplete / 10).toStringAsFixed(0)}/10',
                                          style: TextStyle(
                                              fontFamily: 'Korolev',
                                              decoration: TextDecoration.none,
                                              fontSize: SizeBlock.v! * 10,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  )
                                : Text(
                                    'Your Bonus has been\nAutomatically Sent to Your Wallet',
                                    style: TextStyle(
                                      fontSize: SizeBlock.v! * 18,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'Korolev',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                            if (!myTapometerProvider.isBonusRevealed) const SizedBox(height: 3),
                            if (!myTapometerProvider.isBonusRevealed)
                              Container(
                                width: SizeBlock.h! * 250,
                                height: SizeBlock.v! * 20,
                                child: ProgressBarWidget(myTapometerProvider.pointsComplete),
                              ),
                            const SizedBox(height: 30),
                          ]),
                    )),
              ),
            ),
            SizedBox(height: SizeBlock.v! * 35),
            Column(
              children: <Widget>[
                Text('Tap & Win Bonus',
                    style: TextStyle(
                        fontFamily: 'Korolev',
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontSize: SizeBlock.v! * 18,
                        fontWeight: FontWeight.w700)),
                (!myTapometerProvider.isBonusRevealed && myTapometerProvider.pointsComplete / 10 == 10)
                    ? BlinkText('Bonus Unlocked!',
                        style: TextStyle(
                            fontFamily: 'Korolev',
                            decoration: TextDecoration.none,
                            color: AppColors.redDarkText,
                            // fontSize: SizeBlock.v! * 24,
                            fontSize: SizeBlock.v! * 24,
                            fontWeight: FontWeight.w700),
                        beginColor: AppColors.redDarkText,
                        endColor: Colors.redAccent[700],
                        duration: Duration(milliseconds: 600))
                    : Text('Earn 10 Points to Play!',
                        style: TextStyle(
                            fontFamily: 'Korolev',
                            decoration: TextDecoration.none,
                            color: AppColors.redDarkText,
                            fontSize: SizeBlock.v! * 24,
                            fontWeight: FontWeight.w700))
              ],
            ),
          ],
        );
      },
    );
  }
}
