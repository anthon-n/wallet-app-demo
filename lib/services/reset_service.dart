import 'dart:convert';
import 'package:acresapp/common/helpers/constants.dart';
import 'package:acresapp/providers/name_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ResetService {
  //function to cash out all the funds available in a game
  Future resetAllPlayers(BuildContext context) async {
    try {
      String tempSerialNumber = 'xar647290';
      NamesProvider namesProvider = Provider.of<NamesProvider>(context, listen: false);
      String username = namesProvider.userName == null ?  'test' : namesProvider.userName;
      String password = '123£';
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      final String apiURL = '${Constants.getBaseUrl(context)}/reset';
      final response = await http.get(Uri.parse(apiURL), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': basicAuth
      });
      //print(response.statusCode);
      // print('game cashout response: ${response.body}');
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

  //function to cash out all the funds available in a game
  Future resetPlayer(BuildContext context, String uid) async {
    try {
      String tempSerialNumber = 'xar647290';
      NamesProvider namesProvider = Provider.of<NamesProvider>(context, listen: false);
      String username = namesProvider.userName == null ?  'test' : namesProvider.userName;
      String password = '123£';
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      final String apiURL = '${Constants.getBaseUrl(context)}/reset/$uid';
      final response = await http.get(Uri.parse(apiURL), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': basicAuth
      });
      //print(response.statusCode);
      // print('game cashout response: ${response.body}');
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