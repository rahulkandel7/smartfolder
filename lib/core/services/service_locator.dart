import 'package:get_it/get_it.dart';
import 'package:smart_folder_mobile_app/core/apis/api_calls.dart';
import 'package:smart_folder_mobile_app/features/auth/data/repositories/auth_repositories.dart';
import 'package:smart_folder_mobile_app/features/auth/data/sources/auth_data_sources.dart';

class ServiceLocator {
  static GetIt getIt = GetIt.instance;

  static setupServiceLocator() {
    getIt.registerLazySingleton<ApiCalls>(() => ApiCalls());

    getIt.registerLazySingleton<AuthDataSources>(
      () => AuthDataSourceImpl(
        getIt<ApiCalls>(),
      ),
    );
    getIt.registerLazySingleton<AuthRepositories>(
      () => AuthRepositoriesImpl(
        getIt<AuthDataSources>(),
      ),
    );
  }
}
