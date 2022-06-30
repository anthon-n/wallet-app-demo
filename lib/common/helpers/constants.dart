import 'package:acresapp/providers/name_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Constants {
  static String getBaseUrl(BuildContext context) {
    final NamesProvider namesProvider = Provider.of<NamesProvider>(context, listen: false);
    if (namesProvider.hostName == null) {
      namesProvider.hostName = 'blend.dev1.acres.red';
    }
    return 'https://${namesProvider.hostName}/nex7/wallet-demo';
  }
}