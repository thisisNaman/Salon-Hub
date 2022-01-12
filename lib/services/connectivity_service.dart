import 'dart:async';
import 'package:salon_hub/enums.dart';
import 'package:connectivity/connectivity.dart';

class ConnectivityService {
  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>();
  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      var connectionStatus = _getStatus(result);
      connectionStatusController.add(connectionStatus);
    });
  }

  ConnectivityStatus _getStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      return ConnectivityStatus.Offline;
    } else {
      return ConnectivityStatus.Online;
    }
  }
}
