import 'dart:convert';

GameModel gameModelFromMap(String str) => GameModel.fromMap(str as Map<String, dynamic>);

class GameModel {
  GameModel({
    this.device,
    this.start,
    this.coinIn,
    this.allowPartialCashout,
  });

  Device? device;
  dynamic start;
  dynamic coinIn;
  dynamic allowPartialCashout;

  factory GameModel.fromMap(Map<String, dynamic> json) => GameModel(
    device: json["device"] == null ? null : Device.fromMap(json["device"] as Map<String, dynamic>),
    start: json["start"] == null ? null : json["start"],
    coinIn: json["coin_in"] == null ? null : json["coin_in"],
    allowPartialCashout: json["allow_partial_cashout"] == null ? null : json["allow_partial_cashout"],
  );

}

class Device {
  Device({
    this.sasSerialNumber,
    this.assetNumber,
    this.gameTheme,
    this.currentCredits,
    this.currentCashableAmount,
    this.currentNonrestrictedAmount,
    this.currentRestrictedAmount,
  });

  dynamic sasSerialNumber;
  dynamic assetNumber;
  dynamic gameTheme;
  dynamic currentCredits;
  dynamic currentCashableAmount;
  dynamic currentNonrestrictedAmount;
  dynamic currentRestrictedAmount;

  factory Device.fromMap(Map<String, dynamic> json) => Device(
    sasSerialNumber: json["sas_serial_number"] == null ? null : json["sas_serial_number"],
    assetNumber: json["asset_number"] == null ? null : json["asset_number"],
    gameTheme: json["game_Theme"] == null ? null : json["game_Theme"],
    currentCredits: json["current_credits"] == null ? null : json["current_credits"],
    currentCashableAmount: json["current_cashable_amount"] == null ? null : json["current_cashable_amount"],
    currentNonrestrictedAmount: json["current_nonrestricted_amount"] == null ? null : json["current_nonrestricted_amount"],
    currentRestrictedAmount: json["current_restricted_amount"] == null ? null : json["current_restricted_amount"],
  );

}

