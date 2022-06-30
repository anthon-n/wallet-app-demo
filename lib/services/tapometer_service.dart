import 'dart:convert';
import 'package:acresapp/common/helpers/constants.dart';
import 'package:acresapp/providers/name_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
class TapometerService {
  Future getTapometerProgress(BuildContext context, ) async {
    try {
      NamesProvider namesProvider = Provider.of<NamesProvider>(context, listen: false);
      String username = namesProvider.userName == null ?  'test' : namesProvider.userName;
      String password = '123£';
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      String tempSerialNumber = 'xar647290';
      final String apiURL = '${Constants.getBaseUrl(context)}/bonus/tapometer';
      final response = await http.get(Uri.parse(apiURL), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': basicAuth
      });
      //print('status: ${response.statusCode}');
     // print('scratchometer body: ${response.body}');
      if (response.statusCode == 200) {
       // final dynamic jsonData = json.decode('{"name":"scratchometer","level":684,"pct_complete":10,"is_complete":true}');
        final dynamic jsonData = json.decode(response.body);
        return jsonData;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future redeemTapometerBonus(BuildContext context, ) async {
    try {
      NamesProvider namesProvider = Provider.of<NamesProvider>(context, listen: false);
      String username = namesProvider.userName == null ?  'test' : namesProvider.userName;
      String password = '123£';
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      String tempSerialNumber = 'xar647290';
      final String apiURL = '${Constants.getBaseUrl(context)}/bonus/tapometer/redeem';
      final response = await http.get(Uri.parse(apiURL), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': basicAuth
      });
      print('redeem status: ${response.statusCode}');
      print('redeem body: ${response.body}');
      if (response.statusCode == 200) {
        //final dynamic jsonData = json.decode(response.body);
        //final dynamic data = jsonData['data'];
        return response.body;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

}