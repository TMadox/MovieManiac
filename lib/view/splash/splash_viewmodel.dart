import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/util/deep_linking.dart';
import 'package:movies_app/core/util/injection.dart';

final splashState =
    ChangeNotifierProvider<SplashViewmodel>((ref) => SplashViewmodel());

class SplashViewmodel extends ChangeNotifier {
  DeepLinking deepLinking = locator.get<DeepLinking>();
}
