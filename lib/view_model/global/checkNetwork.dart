import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Network extends StateNotifier<bool> {
  Network() : super(false);

  Future<bool> checkNetwork() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.ethernet) {
      state = true;
      return true;
    } else {
      state = false;
      return false;
    }
  }

  final netCheckProvider = StateNotifierProvider<Network, bool>((ref) {
    return Network();
  });
}
