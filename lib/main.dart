import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/core/util/injection.dart';
import 'package:movies_app/core/util/notifications.dart';
import 'package:movies_app/service/repository/dio_helper.dart';
import 'package:movies_app/view/base/base_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  inject();
  await dotenv.load(fileName: ".env");
  locator.get<DioHelper>().init();
  await locator.get<NotificationManager>().init();
  runApp(ProviderScope(child: MyApp()));
}
