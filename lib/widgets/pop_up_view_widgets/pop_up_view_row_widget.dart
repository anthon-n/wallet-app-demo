
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget buildPopUpViewRow(String title, String subTitle, String icon) {
  return Container(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SvgPicture.asset(icon),
        SizedBox(
          width: SizeBlock.h! * 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: SizeBlock.v! * 18,
                fontWeight: FontWeight.bold,
                height: 1,
                fontFamily: 'Korolev',
              ),
            ),
            SizedBox(
              height: SizeBlock.h! * 5,
            ),
            Text(
              subTitle,
              style: TextStyle(
                  fontFamily: 'Korolev',
                  fontSize: SizeBlock.v! * 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ],
        )
      ],
    ),
  );
}