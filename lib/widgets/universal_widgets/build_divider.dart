import 'package:flutter/material.dart';
//
// class FundSlotsSelectScreen extends StatefulWidget {
//   @override
//   _FundSlotsSelectScreenState createState() => _FundSlotsSelectScreenState();
// }
//
// class _FundSlotsSelectScreenState extends State<FundSlotsSelectScreen> {
//   int expandedListTileIndex = -1;
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       GestureDetector(
//         onTap: () {
//           FocusScope.of(context).unfocus();
//         },
//         child: Scaffold(
//           backgroundColor: AppColors.white,
//           body: Stack(
//             children: <Widget>[
//               Positioned(
//                 top: -SizeBlock.v! * 450,
//                 bottom: SizeBlock.v! * 360,
//                 child: SvgPicture.asset(
//                   AppImages.backgroundHome,
//                   width: MediaQuery.of(context).size.width,
//                   fit: BoxFit.fill,
//                 ),
//               ),
//               Column(
//                 children: <Widget>[
//                   const AppBarWidget(),
//                   SizedBox(height: SizeBlock.v! * 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.max,
//                     children: <Widget>[
//                       WalletGamesWidget(),
//                     ],
//                   ),
//                   SizedBox(height: SizeBlock.v! * 25),
//                   Container(
//                     alignment: Alignment.center,
//                     child: Image.asset(
//                       (expandedListTileIndex == -1)
//                           ? AppIcons.two_circle_bar
//                           : AppIcons.three_circle_bar,
//                       width: SizeBlock.h! * 190,
//                     ),
//                   ),
//                   SizedBox(
//                     height: SizeBlock.h! * 25,
//                   ),
//                   Expanded(
//                     child: ListView(
//                       padding: EdgeInsets.only(
//                         bottom: SizeBlock.v! * 20,
//                         left: SizeBlock.h! * 20,
//                         right: SizeBlock.h! * 20,
//                       ),
//                       shrinkWrap: true,
//                       children: <Widget>[
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             (expandedListTileIndex == -1)
//                                 ? RedTextCardWidgetSlots(
//                                 '2. Fund Slots', 'Select Which Currency.')
//                                 : RedTextCardWidgetSlots(
//                                 '3. Fund Slots', 'Enter the amount.'),
//                             // Spacer(),
//                             Row(
//                               children: <Widget>[
//                                 buildIconWithTextVertical(
//                                     AppIcons.timer, 'TIMER'),
//                                 SizedBox(width: SizeBlock.h! * 10),
//                                 Text(
//                                   ':20',
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontFamily: 'KorolevCompressed',
//                                       fontSize: SizeBlock.v! * 36,
//                                       fontWeight: FontWeight.w700),
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: SizeBlock.v! * 20,
//                         ),
//                         buildDivider(),
//                         RowTwoItemFundSlotsTablesWidget(
//                           'Cash',
//                           '1,200.00',
//                           paddingValue: 10,
//                           isExpanded: expandedListTileIndex == 0,
//                           onPressed: () {
//                             expandListTile(0);
//                           },
//                           isFundTable: false,
//                           onNavigateTo: () {
//                             Navigator.push<dynamic>(
//                               context,
//                               MaterialPageRoute<dynamic>(
//                                   builder: (BuildContext context) =>
//                                       TransferCompleteFundSlotsScreen()),
//                             );
//                           },
//                         ),
//                         buildDivider(),
//                         RowTwoItemFundSlotsTablesWidget(
//                           'Free Play',
//                           '322.00',
//                           isCount: true,
//                           isExpanded: expandedListTileIndex == 1,
//                           onPressed: () {
//                             expandListTile(1);
//                           },
//                           isFundTable: false,
//                           onNavigateTo: () {
//                             Navigator.push<dynamic>(
//                               context,
//                               MaterialPageRoute<dynamic>(
//                                   builder: (BuildContext context) =>
//                                       TransferCompleteFundSlotsScreen()),
//                             );
//                           },
//                         ),
//                         buildDivider(),
//                         RowTwoItemFundSlotsTablesWidget(
//                           'Points',
//                           '100',
//                           isDollarSignNeeded: false,
//                           isExpanded: expandedListTileIndex == 2,
//                           onPressed: () {
//                             expandListTile(2);
//                           },
//                           isFundTable: false,
//                           onNavigateTo: () {
//                             Navigator.push<dynamic>(
//                               context,
//                               MaterialPageRoute<dynamic>(
//                                   builder: (BuildContext context) =>
//                                       TransferCompleteFundSlotsScreen()),
//                             );
//                           },
//                         ),
//                         buildDivider(),
//                         RowTwoItemFundSlotsTablesWidget(
//                           'MarkerTrax',
//                           '500.00',
//                           isTMSignNeeded: true,
//                           isIconNeeded: true,
//                           isExpanded: expandedListTileIndex == 3,
//                           onPressed: () {
//                             expandListTile(3);
//                           },
//                           isFundTable: false,
//                           onNavigateTo: () {
//                             Navigator.push<dynamic>(
//                               context,
//                               MaterialPageRoute<dynamic>(
//                                   builder: (BuildContext context) =>
//                                       TransferCompleteFundSlotsScreen()),
//                             );
//                           },
//                         ),
//                         buildDivider(),
//                         SizedBox(
//                           height: SizeBlock.v! * 30,
//                         ),
//                         Container(
//                           margin: EdgeInsets.symmetric(
//                               horizontal: SizeBlock.h! * 50),
//                           decoration: BoxDecoration(
//                               borderRadius:
//                               BorderRadius.circular(SizeBlock.v! * 10),
//                               border: Border.all(color: AppColors.grey)),
//                           child: CustomButton(
//                             onTap: () {
//                               Navigator.pop(context);
//                             },
//                             text: 'CANCEL',
//                             color: AppColors.white,
//                             textStyle: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: SizeBlock.v! * 16,
//                                 fontFamily: 'Korolev',
//                                 fontWeight: FontWeight.w600,
//                                 letterSpacing: 1.2),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       );
//   }
//
//   void expandListTile(int index) {
//     if (index == expandedListTileIndex) {
//       setState(() {
//         expandedListTileIndex = -1;
//       });
//       return;
//     } else {
//       setState(() {
//         expandedListTileIndex = index;
//       });
//     }
//   }
// }


Widget buildDivider() {
  return Divider(height: 1.3, color: Colors.grey.withOpacity(0.5));
}
