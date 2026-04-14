import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity;
  final InternetConnection _internetConnection;

  ConnectivityService(this._connectivity, this._internetConnection) {
    _init();
  }

  final _controller = StreamController<bool>.broadcast();

  Stream<bool> get onConnectivityChanged async* {
    yield* _controller.stream;
  }

  void _init() {
    _connectivity.onConnectivityChanged.listen((result) async {
      try {
        final hasInternet = await _internetConnection.hasInternetAccess.timeout(
          const Duration(seconds: 3),
          onTimeout: () => true,
        );
        print('Net status change - Connectivity: $result, Has internet access: $hasInternet');
        _controller.add(hasInternet);
      } catch (e) {
        print('Net status change - Error checking access: $e');
        _controller.add(true); // Fallback to true on error
      }
    });
  }


  Future<bool> get hasInternet async {
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) {
        print('Checking connectivity - Result: NO CONNECTION');
        return false;
      }

      // Try actual internet access check with a timeout
      final hasAccess = await _internetConnection.hasInternetAccess.timeout(
        const Duration(seconds: 3),
        onTimeout: () {
          print('Checking connectivity - Access check timed out, falling back to basic connectivity');
          return true; // Fallback to true if we have connection but access check is slow
        },
      );
      
      print('Checking connectivity - Result: $hasAccess');
      return hasAccess;
    } catch (e) {
      print('Checking connectivity - Error: $e');
      return true; // Fallback to true on error to avoid blocking the user
    }
  }


}

