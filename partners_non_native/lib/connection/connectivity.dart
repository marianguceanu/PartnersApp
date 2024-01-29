import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:partners_non_native/constants/app_constants.dart';
import 'package:partners_non_native/service/server_service.dart';

class ConnectionStatusManager {
  static final ConnectionStatusManager _singletonInstance =
      ConnectionStatusManager._internal();
  ConnectionStatusManager._internal();

  static ConnectionStatusManager getInstance() => _singletonInstance;

  bool hasConnection = false;

  StreamController connectionChangeController = StreamController.broadcast();

  final Connectivity _connectivity = Connectivity();

  void initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    hasNetwork();
  }

  Stream get connectionChange => connectionChangeController.stream;

  void dispose() {
    connectionChangeController.close();
  }

  void _connectionChange(ConnectivityResult result) {
    hasNetwork();
  }

  Future<bool> hasNetwork() async {
    try {
      await dio.get('${AppConstants.serverUrl}/all');
      hasConnection = true;
    } on DioException catch (e) {
      print(e);
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        hasConnection = false;
      }
    }
    connectionChangeController.add(hasConnection);
    return hasConnection;
  }
}
