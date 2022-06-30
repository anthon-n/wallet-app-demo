import 'package:acresapp/common/helpers/app-colors.dart';
import 'package:acresapp/common/helpers/app-icons.dart';
import 'package:acresapp/common/helpers/app-images.dart';
import 'package:acresapp/common/helpers/size_block.dart';
import 'package:acresapp/widgets/universal_widgets/app-bar-widget.dart';
import 'package:acresapp/widgets/universal_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TransferCompleteFundTablesScreen extends StatefulWidget {
  @override
  _TransferCompleteFundTablesScreenState createState() =>
      _TransferCompleteFundTablesScreenState();
}

class _TransferCompleteFundTablesScreenState
    extends State<TransferCompleteFundTablesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body:
          Stack(
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: SizeBlock.v! * 25),
                child: Column(children: <Widget>[
           AppBarWidget(),
          SizedBox(height: SizeBlock.v! * 85),
          Container(
            height: SizeBlock.v! * 175,
            width: SizeBlock.v! * 175,
            padding: EdgeInsets.all(SizeBlock.v! * 45),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SizeBlock.v! * 100),
                border: Border.all(
                    width: SizeBlock.v! * 7, color: AppColors.greenLight)),
            child: SvgPicture.asset(AppIcons.done),
          ),
          SizedBox(
            height: SizeBlock.v! * 30,
          ),
          Text(
            'Transfer Complete',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.redDarkText,
                fontSize: SizeBlock.v! * 24,
                fontFamily: 'Korolev',
                fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: SizeBlock.v! * 5,
          ),
          Text(
            'The Dealer Has Accepted\nYour Transaction',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.grey,
                fontSize: SizeBlock.v! * 18,
                fontFamily: 'Korolev',
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: SizeBlock.v! * 70,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SizeBlock.v! * 10),
                border: Border.all(color: AppColors.grey)),
            child: CustomButton(
              onTap: () {
                Navigator.pop(context);
              },
              text: 'RETURN TO HOMESCREEN',
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
      ),
            ],
          )
    );
  }
}
