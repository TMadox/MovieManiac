import 'dart:async';
import 'dart:developer';

import 'package:flutter/services.dart';

class DeepLinking {
  static const stream = EventChannel('poc.deeplink.flutter.dev/events');

  static const platform = MethodChannel('poc.deeplink.flutter.dev/channel');

  final StreamController<Map> _stateController = StreamController();

  Stream<Map> get state => _stateController.stream;

  Sink<Map> get stateSink => _stateController.sink;

  _onRedirected(Map input) {
    stateSink.add(input);
  }

  DeepLinking() {
    startUri().then((value) {
      log("first start");
      _onRedirected({"link": value, "first": true});
    });
    stream
        .receiveBroadcastStream()
        .listen((value) => _onRedirected({"link": value, "first": false}));
  }

  Future<String> startUri() async {
    try {
      log("Initiated deep linking");
      return await platform.invokeMethod('initialLink');
    } on PlatformException catch (e) {
      return "Failed to Invoke: '${e.message}'.";
    }
  }
}
