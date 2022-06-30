import 'package:acresapp/common/helpers/size_block.dart';
import 'package:flutter/material.dart';

class LetterGameContainerWidget extends StatelessWidget {
  const LetterGameContainerWidget(this.text, this.backgroundColor);
  final String text;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeBlock.v! * 51,
      width: SizeBlock.v! * 51,
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(SizeBlock.v! * 12)),
      alignment: Alignment.center,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontFamily: 'Korolev',
              decoration: TextDecoration.none,
              fontSize: SizeBlock.v! * 42,
              color: Colors.white,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
