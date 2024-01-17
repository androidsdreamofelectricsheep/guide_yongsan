import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl({required this.connectivity});

  @override
  Future<bool> get isConnected => _isConnected();

  Future<bool> _isConnected() async {
    final checkConnectivity = await connectivity.checkConnectivity();

    return checkConnectivity == ConnectivityResult.mobile ||
        checkConnectivity == ConnectivityResult.wifi ||
        checkConnectivity == ConnectivityResult.ethernet;
  }
}
