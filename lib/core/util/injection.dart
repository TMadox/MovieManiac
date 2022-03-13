import 'package:get_it/get_it.dart';
import 'package:movies_app/core/util/deep_linking.dart';
import 'package:movies_app/core/util/notifications.dart';
import 'package:movies_app/service/repository/dio_helper.dart';
import 'package:movies_app/service/repository/get_repo.dart';

final locator = GetIt.instance;

void inject() {
  locator.registerLazySingleton<DioHelper>(() => DioHelper());
  locator.registerLazySingleton<GetRepo>(() => GetRepo());
  // locator.registerLazySingleton<NavigatorService>(() => NavigatorService());
  locator.registerLazySingleton<DeepLinking>(() => DeepLinking());
  locator
      .registerLazySingleton<NotificationManager>(() => NotificationManager());
}
