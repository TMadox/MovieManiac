import 'dart:async';
import 'dart:developer';

import 'package:flutter/services.dart';

class DeepLinking {
  static const stream = EventChannel('poc.deeplink.flutter.dev/events');

  static const platform = MethodChannel('poc.deeplink.flutter.dev/channel');

  final StreamController<String> _stateController = StreamController();

  Stream<String> get state => _stateController.stream;

  Sink<String> get stateSink => _stateController.sink;

  _onRedirected(String uri) {
    stateSink.add(uri);
  }

  DeepLinking() {
    startUri().then(_onRedirected);
    stream.receiveBroadcastStream().listen((d) => _onRedirected(d));
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
