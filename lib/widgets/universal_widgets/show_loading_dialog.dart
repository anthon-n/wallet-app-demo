import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showLoadingDialog(BuildContext context) {
  showDialog<Dialog>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24.0))),
        child: Container(
          color: Colors.transparent,
          height: SizeBlock.v! * 100,
          width: SizeBlock.v! * 100,
          child: const Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.redDark))),
        ),
        // },
        // )
      ));
}
