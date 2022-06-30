import 'dart:convert';
import 'package:acresapp/common/helpers/constants.dart';
import 'package:acresapp/providers/name_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class GameService {
  Future<Map<String, dynamic>?> getGames(BuildContext context, ) async {
    try {
      NamesProvider namesProvider = Provider.of<NamesProvider>(context, listen: false);
      String username = namesProvider.userName == null ?  'test' : namesProvider.userName;
      String password = '123£';
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      final String apiURL = '${Constants.getBaseUrl(context)}/sessions';
      final response = await http.get(Uri.parse(apiURL), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': basicAuth

      });
      //print(response.statusCode);
      print(json.decode(response.body) as Map<String, dynamic>);
      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        return <String, dynamic>{};
      }
    } catch (e) {
      print(e);
      return <String, dynamic>{};
    }
  }
  //todo use serial number
  //function to cash out all the funds available in a game
  Future cashOutGame(BuildContext context, String serialNumber, double amount) async {
    try {
      String tempSerialNumber = '882279';
      NamesProvider namesProvider = Provider.of<NamesProvider>(context, listen: false);
      String username = namesProvider.userName == null ?  'test' : namesProvider.userName;
      String password = '123£';
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      final String apiURL = '${Constants.getBaseUrl(context)}/cashout/$serialNumber/${(amount * 100).toInt()}';
      final response = await http.get(Uri.parse(apiURL), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': basicAuth
      });
      print(response.statusCode);
      print('game cashout response: ${response.body}');
      if (response.statusCode == 200) {
        // final dynamic jsonData = json.decode(response.body);
        // final dynamic data = jsonData['data'];
        // return data;
        return 0;
      } else {
        return -1;
      }
    } catch (e) {
      print(e);
      return -1;
    }
  }

  //todo use serial number
  //function to cash out all the funds available in a game
  Future cashOutAllGameAmt(BuildContext context, String serialNumber) async {
    try {
      String tempSerialNumber = '882279';
      NamesProvider namesProvider = Provider.of<NamesProvider>(context, listen: false);
      String username = namesProvider.userName == null ?  'test' : namesProvider.userName;
      String password = '123£';
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      final String apiURL = '${Constants.getBaseUrl(context)}/cashout/$serialNumber/${9999999999}';
      final response = await http.get(Uri.parse(apiURL), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': basicAuth
      });
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        // final dynamic jsonData = json.decode(response.body);
        // final dynamic data = jsonData['data'];
        // return data;
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