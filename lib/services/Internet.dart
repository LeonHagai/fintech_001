
import 'package:connectivity_plus/connectivity_plus.dart';

Future<void> checkInternetConnectivity() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    print('No internet connection.');
  } else if (connectivityResult == ConnectivityResult.mobile) {
    print('Mobile data connection available.');
  } else if (connectivityResult == ConnectivityResult.wifi) {
    print('WiFi connection available.');
  }
}