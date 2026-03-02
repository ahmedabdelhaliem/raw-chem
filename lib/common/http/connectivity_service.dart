// import 'dart:async';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

// class ConnectivityService {
//   ConnectivityService._() {
//     _init();
//   }
//   static final ConnectivityService instance = ConnectivityService._();

//   final _controller = StreamController<bool>.broadcast();

//   Stream<bool> get onConnectivityChanged async*{
//     yield* _controller.stream;
//   }

//   void _init() {
//     Connectivity().onConnectivityChanged.listen((result) async {       // :contentReference[oaicite:2]{index=2}
//       final hasInternet = await InternetConnection().hasInternetAccess;
//       _controller.add(hasInternet);
//     });
//   }
// }
