import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? text;
  final Color? color;
  final BorderRadius? borderRadius;
  final IconData? icon;
  final TextStyle? textStyle;

  const CustomButton(
      {this.onTap,
      this.text,
      this.color,
      this.borderRadius,
      this.icon,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeBlock.v! * 44,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeBlock.v! * 10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(SizeBlock.v! * 10),
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: (color != null)
                ? MaterialStateProperty.all(color)
                : MaterialStateProperty.all(AppColors.grey),
            overlayColor: (color != null && color == AppColors.redDark)
                ? MaterialStateProperty.all(
                    AppColors.lightGrey.withOpacity(0.1))
                : MaterialStateProperty.all(AppColors.grey.withOpacity(0.1)),
          ),
          onPressed: onTap ?? () {},
          child: Text(text!, style: textStyle),
        ),
      ),
    );
  }
}
