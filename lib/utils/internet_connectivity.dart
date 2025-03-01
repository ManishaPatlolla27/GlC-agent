import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> isNetworkAvailable() async {
  // Get the current connectivity status (Wi-Fi, Mobile, or None)
  var connectivityResult = await Connectivity().checkConnectivity();

  // Check if the device is connected to Wi-Fi or Mobile Data
  if (connectivityResult.contains(ConnectivityResult.mobile) ||
      connectivityResult.contains(ConnectivityResult.wifi)) {
    return true; // Internet connection is available
  } else {
    return false; // No internet connection
  }
}
