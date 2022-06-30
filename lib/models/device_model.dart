import 'dart:convert';
DeviceModel deviceModelFromMap(String str) => DeviceModel.fromMap(str as Map<String, dynamic>);

class DeviceModel {

  DeviceModel({
    required this.sasSerialNumber,
    required this.assetNumber,
    required this.gameTheme,
    required this.currentCredits,
    required this.currentCashableAmount,
    required this.currentNonrestrictedAmount,
    required this.currentRestrictedAmount,
  });

  dynamic sasSerialNumber;
  dynamic assetNumber;
  dynamic gameTheme;
  dynamic currentCredits;
  dynamic currentCashableAmount;
  dynamic currentNonrestrictedAmount;
  dynamic currentRestrictedAmount;

  factory DeviceModel.fromMap(Map<String, dynamic> json) => DeviceModel(
    sasSerialNumber: json["sas_serial_number"] == null ? null : json['sas_serial_number'],
    assetNumber: json['asset_number'] == null ? null : json['asset_number'],
    gameTheme: json['game_Theme'] == null ? null : json['game_Theme'],
    currentCredits: json['current_credits'] == null ? null : json['current_credits'],
    currentCashableAmount: json['current_cashable_amount'] == null ? null : json['current_cashable_amount'],
    currentNonrestrictedAmount: json['current_nonrestricted_amount'] == null ? null : json['current_nonrestricted_amount'],
    currentRestrictedAmount: json["current_restricted_amount"] == null ? null : json['current_restricted_amount'],
  );

}
