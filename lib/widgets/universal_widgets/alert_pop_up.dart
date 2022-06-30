import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showAlertPopUp(BuildContext context, String title, String message) {
  showDialog<Widget>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        title: Text(
          title,
            style: TextStyle(color: AppColors.redDark, fontFamily: 'Korolev', fontSize: SizeBlock.v! * 22, fontWeight: FontWeight.w700),
        ),
        content: Text(
          message,
            style: TextStyle(color: AppColors.grey, fontFamily: 'Korolev', fontSize: SizeBlock.v! * 16, fontWeight: FontWeight.w500),
        ),
      ));
}