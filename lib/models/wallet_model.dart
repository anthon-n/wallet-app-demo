
WalletModel walletModelFromMap(dynamic str) => WalletModel.fromMap(str as Map<String, dynamic>);

class WalletModel {
  WalletModel({
    this.type,
    this.name,
    this.balance,
    this.cashable,
  });

  int? type;
  String? name;
  int? balance;
  bool? cashable;

  factory WalletModel.fromMap(Map<String, dynamic> json) => WalletModel(
    type: json['type'] as int,
    name: json['name'] as String,
    balance: json['balance'] as int,
    cashable: json['cashable'] as bool,
  );

}