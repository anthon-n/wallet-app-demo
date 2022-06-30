import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatefulWidget {
  @override
  _CustomLoadingIndicatorState createState() => _CustomLoadingIndicatorState();
}

class _CustomLoadingIndicatorState extends State<CustomLoadingIndicator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeBlock.v! * 50,
      width: SizeBlock.v! * 50,
      child: const CircularProgressIndicator(valueColor:
      AlwaysStoppedAnimation(AppColors.redDark),),
    );
  }
}
