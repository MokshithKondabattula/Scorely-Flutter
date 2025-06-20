import 'package:connectivity_plus/connectivity_plus.dart';

class Internet {
  static Future<bool> checkInternet() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if ([
        ConnectivityResult.mobile,
        // ignore: collection_methods_unrelated_type
        ConnectivityResult.wifi,
        // ignore: collection_methods_unrelated_type
      ].contains(connectivityResult)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
