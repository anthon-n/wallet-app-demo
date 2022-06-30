import 'dart:convert';
import 'package:acresapp/common/helpers/constants.dart';
import 'package:acresapp/models/device_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class DeviceService {
  Future<DeviceModel?> getDevice(BuildContext context, String deviceSerialNumber) async {
    try {
      String tempSerialNumber = 'xar647290';
      final String apiURL = '${Constants.getBaseUrl(context)}/device/${deviceSerialNumber}';
      final response = await http.get(Uri.parse(apiURL), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      if (response.statusCode == 200) {
        final dynamic jsonData = json.decode(response.body);
        final dynamic data = jsonData;
        DeviceModel deviceModel = DeviceModel(sasSerialNumber: data['sas_serial_number'], assetNumber: data['asset_number'], gameTheme: data['game_Theme'], currentCredits: data['current_credits'], currentCashableAmount: data['current_cashable_amount'], currentNonrestrictedAmount: data['current_nonrestricted_amount'], currentRestrictedAmount: data['current_restricted_amount']);
        return deviceModel;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}