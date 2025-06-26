import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class Internet {
  static Future<bool> checkInternet() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi)) {
        final result = await InternetAddress.lookup('google.com');
        return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      }

      return false;
    } catch (_) {
      return false;
    }
  }
}
