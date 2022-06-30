import 'dart:convert';
import 'package:acresapp/common/helpers/constants.dart';
import 'package:acresapp/providers/name_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class TablesSlotService {

  Future fundSlot(BuildContext context, String serialNumber, double amount, String type) async {
    try {
      NamesProvider namesProvider = Provider.of<NamesProvider>(context, listen: false);
      String username = namesProvider.userName == null ?  'test' : namesProvider.userName;
      String password = '123£';
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      final String apiURL = '${Constants.getBaseUrl(context)}/fund/$serialNumber/${(amount * 100).toInt()}/$type';
      final response = await http.get(Uri.parse(apiURL), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': basicAuth
      });
      print('fund slot status: ${response.statusCode}');
      print('fund slot body: ${response.body}');
      if (response.statusCode == 200) {
        return 0;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future fundTable(BuildContext context, String serialNumber, double amount, String type) async {
    try {
      NamesProvider namesProvider = Provider.of<NamesProvider>(context, listen: false);
      String username = namesProvider.userName == null ?  'test' : namesProvider.userName;
      String password = '123£';
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      final String apiURL = '${Constants.getBaseUrl(context)}/fund/$serialNumber/${(amount).toInt() * 100}/$type';
      final response = await http.get(Uri.parse(apiURL), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': basicAuth
      });
      print('fund slot status: ${response.statusCode}');
      print('fund slot body: ${response.body}');
      if (response.statusCode == 200) {
        return 0;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future cashOutTable(BuildContext context, String serialNumber, int amount) async  {
    try {
      NamesProvider namesProvider = Provider.of<NamesProvider>(context, listen: false);
      String username = namesProvider.userName == null ?  'test' : namesProvider.userName;
      String password = '123£';
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      final String apiURL = '${Constants.getBaseUrl(context)}/cashout/$serialNumber/${(amount).toInt()}';
      final response = await http.get(Uri.parse(apiURL), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': basicAuth
      });
      print('fund slot status: ${response.statusCode}');
      print('fund slot body: ${response.body}');
      if (response.statusCode == 200) {
        return 0;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

}