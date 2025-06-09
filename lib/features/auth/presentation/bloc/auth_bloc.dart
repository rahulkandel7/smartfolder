import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_folder_mobile_app/features/auth/data/repositories/auth_repositories.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositories authRepositories;
  AuthBloc(this.authRepositories) : super(AuthInitial()) {
    on<RegisterEvent>(_userRegister);
    on<LoginEvent>(_loginUser);
  }

  _userRegister(RegisterEvent event, emit) async {
    emit(RegisterLoadingState());
    final result =
        await authRepositories.registerUser(userData: event.userData);
    result.fold(
      (error) => emit(RegisterErrorState(message: error.errorMessage)),
      (success) => emit(
        RegisterSuccessState(message: success),
      ),
    );
  }

  _loginUser(LoginEvent event, emit) async {
    emit(LoginLoadingState());
    final result = await authRepositories.loginUser(loginData: event.loginData);
    result.fold(
      (error) => emit(LoginErrorState(message: error.errorMessage)),
      (success) => emit(
        LoginSuccessState(message: success),
      ),
    );
  }
}
