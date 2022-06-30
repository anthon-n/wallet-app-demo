
import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget buildPopUpViewColumn(String title, String subTitle, String icon) {
  return Container(
    decoration: BoxDecoration(border: Border.all(color: AppColors.grey, width: SizeBlock.v! * 1), borderRadius: BorderRadius.circular(SizeBlock.v! * 10)),
    width: SizeBlock.h! * 136,
    height: SizeBlock.v! * 165,
    padding: EdgeInsets.all(SizeBlock.v! * 10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: SizeBlock.v! * 20,
        ),
        SvgPicture.asset(icon),
        SizedBox(
          height: SizeBlock.v! * 20,
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SizeBlock.v! * 24,
                  fontWeight: FontWeight.bold,
                  height: 1,
                  fontFamily: 'Korolev',
                ),
              ),
              SizedBox(
                height: SizeBlock.v! * 5,
              ),
              Text(
                subTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Korolev',
                    fontSize: SizeBlock.v! * 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey),
              ),
            ],
          ),
        ),

      ],
    ),
  );
}