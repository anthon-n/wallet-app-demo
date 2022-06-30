import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/app-images.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:acresapp/providers/name_provider.dart';
import 'package:acresapp/services/reset_service.dart';
import 'package:acresapp/widgets/universal_widgets/alert_pop_up.dart';
import 'package:acresapp/widgets/universal_widgets/build_divider.dart';
import 'package:acresapp/widgets/universal_widgets/app-bar-widget.dart';
import 'package:acresapp/widgets/universal_widgets/custom_button.dart';
import 'package:acresapp/widgets/universal_widgets/custom_keyboard.dart';
import 'package:acresapp/widgets/universal_widgets/show_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _hostNameEditingController =
      TextEditingController();
  ResetService get resetService => GetIt.instance<ResetService>();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();


  NamesProvider? _namesProvider;
  @override
  void initState() {
    _namesProvider = Provider.of<NamesProvider>(context, listen: false);
    _nameEditingController.text = _namesProvider!.userName;
    _hostNameEditingController.text = _namesProvider!.hostName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.white,
        body: Stack(
          children: <Widget>[
            Positioned(
              top: -SizeBlock.v! * 450,
              bottom: SizeBlock.v! * 360,
              child: SvgPicture.asset(
                AppImages.backgroundHome,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
            ),
            Column(
              children: <Widget>[
                AppBarWidget(isMenuNeeded: false,),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: SizeBlock.h! * 25, vertical: SizeBlock.v! * 150),
                      children: <Widget>[
                    SizedBox(height: SizeBlock.v! * 20),
                    SizedBox(height: SizeBlock.v! * 10),
                    SizedBox(
                      height: SizeBlock.v! * 25,
                    ),
                    Container(
                      height: SizeBlock.v! * 44,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(SizeBlock.v! * 10),
                        color: AppColors.lightGrey,
                      ),
                      child: Center(
                        child: KeyboardActions(
                          disableScroll: true,
                          config: CustomKeyboard.buildConfig(context, _nodeText1),
                          child: TextField(
                            focusNode: _nodeText1,
                            controller: _nameEditingController,
                            textAlign: TextAlign.center,
                            cursorColor: AppColors.redDarkText,
                            keyboardType: TextInputType.name,
                            style: TextStyle(
                                color: AppColors.grey,
                                fontSize: SizeBlock.v! * 20,
                                fontFamily: 'Korolev',
                                fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              // contentPadding: EdgeInsets.symmetric(
                              //     horizontal: SizeBlock.h! * 10),
                              border: InputBorder.none,
                              isDense: true,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: 'Enter Your Name',
                              hintStyle: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: SizeBlock.v! * 20,
                                  fontFamily: 'Korolev',
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: SizeBlock.v! * 15),
                    Container(
                      height: SizeBlock.v! * 44,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(SizeBlock.v! * 10),
                        color: AppColors.lightGrey,
                      ),
                      child: Center(
                        child: KeyboardActions(
                          disableScroll: true,
                          config: CustomKeyboard.buildConfig(context, _nodeText2),
                          child: TextField(
                            focusNode: _nodeText2,
                            controller: _hostNameEditingController,
                            textAlign: TextAlign.center,
                            cursorColor: AppColors.redDarkText,
                            keyboardType: TextInputType.url,
                            style: TextStyle(
                                color: AppColors.grey,
                                fontSize: SizeBlock.v! * 20,
                                fontFamily: 'Korolev',
                                fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              // contentPadding: EdgeInsets.symmetric(
                              //     horizontal: SizeBlock.h! * 10),
                              border: InputBorder.none,
                              isDense: true,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: 'Enter Host',
                              hintStyle: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: SizeBlock.v! * 20,
                                  fontFamily: 'Korolev',
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: SizeBlock.v! * 15),
                    buildDivider(),
                    SizedBox(height: SizeBlock.v! * 50),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: SizeBlock.h! * 50),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(SizeBlock.v! * 10),
                          border: Border.all(color: AppColors.grey)),
                      child: CustomButton(
                        onTap: () async {
                          SharedPreferences _prefs = await SharedPreferences.getInstance();
                          _prefs.setString("user_name", _nameEditingController.text);
                          _prefs.setString("host_name", _hostNameEditingController.text);
                          _namesProvider!.changeName(_nameEditingController.text);
                          _namesProvider!.changeHostName(_hostNameEditingController.text);
                          Navigator.pop(context);
                        },
                        text: 'SAVE',
                        color: AppColors.white,
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: SizeBlock.v! * 16,
                            fontFamily: 'Korolev',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2),
                      ),
                    ),
                        SizedBox(height: SizeBlock.v! * 15),
                        Container(
                          margin:
                          EdgeInsets.symmetric(horizontal: SizeBlock.h! * 50),
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(SizeBlock.v! * 10),
                              border: Border.all(color: AppColors.grey)),
                          child: CustomButton(
                            onTap: () async {
                              showLoadingDialog(context);
                              dynamic result = await resetService.resetAllPlayers(context);
                              //popping loading dialog
                              Navigator.pop(context);
                              if (result == -1) {
                                showAlertPopUp(context, 'Error Occurred', 'Try again');
                              }
                            },
                            text: 'RESET',
                            color: AppColors.white,
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: SizeBlock.v! * 16,
                                fontFamily: 'Korolev',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.2),
                          ),
                        ),
                  ]),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
