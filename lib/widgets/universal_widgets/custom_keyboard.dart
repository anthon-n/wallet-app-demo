import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:flutter/cupertino.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_item.dart';

class CustomKeyboard {
     /// Creates the [KeyboardActionsConfig] to hook up the fields
  /// and their focus nodes to our [FormKeyboardActions].
  static KeyboardActionsConfig buildConfig(BuildContext context, FocusNode focusNode) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: AppColors.white,
      defaultDoneWidget: Text('Done', style: TextStyle(
          fontFamily: 'KorolevCompressed',
          decoration: TextDecoration.none,
          color: AppColors.redDarkText,
          fontWeight: FontWeight.w700,
          fontSize: SizeBlock.v! * 16)),
      nextFocus: false,
      actions: [
        KeyboardActionsItem(
          focusNode: focusNode,
          displayDoneButton: true,
          onTapAction: () {

          },
        ),
      ],
    );
  }
}