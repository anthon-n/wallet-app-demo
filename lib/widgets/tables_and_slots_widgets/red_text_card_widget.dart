import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:flutter/material.dart';

class RedTextCardWidgetSlots extends StatelessWidget {
  RedTextCardWidgetSlots(this.title, this.subTitle,
      {this.colorTitle = AppColors.redDarkText});

  final String title;
  final String subTitle;
  Color colorTitle = AppColors.redDarkText;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        margin: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Korolev',
                color: colorTitle,
                fontSize: SizeBlock.v! * 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              subTitle,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'Korolev',
                color: AppColors.grey,
                fontSize: SizeBlock.v! * 18,
                fontWeight: FontWeight.w400,
                height: SizeBlock.v! * 1.2
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class RedTextCardWidgetTables extends StatelessWidget {
  RedTextCardWidgetTables(this.title, this.subTitle,
      {this.colorTitle = AppColors.redDarkText});

  final String title;
  final String subTitle;
  Color colorTitle = AppColors.redDarkText;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        margin: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Korolev',
                color: colorTitle,
                fontSize: SizeBlock.v! * 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              subTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Korolev',
                  color: AppColors.grey,
                  fontSize: SizeBlock.v! * 18,
                  fontWeight: FontWeight.w400,
                  height: SizeBlock.v! * 1.2
              ),
            ),
          ],
        ),
      ),
    );
  }
}