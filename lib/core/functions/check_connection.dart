import 'package:connectivity/connectivity.dart';

class CheckConnection{
  final Connectivity _connectivity = Connectivity();
  ConnectivityResult result;
  String _connectionStatus = "";

  Future<String> initConnection() async {
    try{
      result = await _connectivity.checkConnectivity();
    }catch(e){
      print(e);
    }
    updateConnectionStatus(result);
    return _connectionStatus;
  }

  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
         _connectionStatus = "wifi";
         break;
      case ConnectivityResult.mobile:
         _connectionStatus = "mobile";
         break;
      case ConnectivityResult.none:
        _connectionStatus = "none";
        break;
      default:
        _connectionStatus = 'Failed to get connectivity.';
        break;
    }
  }
}