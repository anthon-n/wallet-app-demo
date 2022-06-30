import 'dart:convert';
import 'package:acresapp/common/helpers/constants.dart';
import 'package:acresapp/providers/name_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class WalletService {
  Future getWallets(BuildContext context, ) async {
    try {
      //print('getting accounts');
      NamesProvider namesProvider = Provider.of<NamesProvider>(context, listen: false);
      String username = namesProvider.userName == null ?  'test' : namesProvider.userName;
      String password = '123£';
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      String tempSerialNumber = 'xar647290';
      final String apiURL = '${Constants.getBaseUrl(context)}/wallet';
      final response = await http.get(Uri.parse(apiURL), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': "${basicAuth}"

      });
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return <dynamic>[];
      }
    } catch (e) {
      print(e);
      return <dynamic>[];
    }
  }


  Future redeemPointsToFreePlay(BuildContext context, int amount) async {
    try {
      //print('getting accounts');
      NamesProvider namesProvider = Provider.of<NamesProvider>(context, listen: false);
      String username = namesProvider.userName == null ?  'test' : namesProvider.userName;
      String password = '123£';
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      String tempSerialNumber = 'xar647290';
      final String apiURL = '${Constants.getBaseUrl(context)}/bonus/points/redeem/${amount}';
      final response = await http.get(Uri.parse(apiURL), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': "${basicAuth}"
      });
      //print(response.statusCode);
     // print(response.body);
      if (response.statusCode == 200) {
        return 0;
      } else {
        return -1;
      }
    } catch (e) {
      print(e);
      return -1;
    }
  }

}