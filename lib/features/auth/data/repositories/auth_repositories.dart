import 'package:dartz/dartz.dart';
import 'package:smart_folder_mobile_app/core/apis/api_error.dart';
import 'package:smart_folder_mobile_app/core/apis/custom_dio_exceptoin.dart';
import 'package:smart_folder_mobile_app/features/auth/data/sources/auth_data_sources.dart';

abstract class AuthRepositories {
  Future<Either<ApiError, String>> registerUser(
      {required Map<String, dynamic> userData});
}

class AuthRepositoriesImpl extends AuthRepositories {
  final AuthDataSources authDataSources;

  AuthRepositoriesImpl(this.authDataSources);

  @override
  Future<Either<ApiError, String>> registerUser(
      {required Map<String, dynamic> userData}) async {
    try {
      final result = await authDataSources.registerUser(userData: userData);
      return right(result);
    } on CustomDioException catch (e) {
      print(e.message);
      return left(
        ApiError(
          errorMessage: e.message.toString(),
        ),
      );
    }
  }
}
