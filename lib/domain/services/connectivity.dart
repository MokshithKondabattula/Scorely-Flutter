import 'package:connectivity_plus/connectivity_plus.dart';

class Internet {
  static Future<bool> checkInternet() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult.contains(ConnectivityResult.none)) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }
}
