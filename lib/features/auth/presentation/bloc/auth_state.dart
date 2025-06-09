part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {
  final String message;
  RegisterSuccessState({required this.message});
}

class RegisterErrorState extends AuthState {
  final String message;
  RegisterErrorState({required this.message});
}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
  final String message;
  LoginSuccessState({required this.message});
}

class LoginErrorState extends AuthState {
  final String message;
  LoginErrorState({required this.message});
}

class LogoutLoadingState extends AuthState {}

class LogoutSuccessState extends AuthState {
  final String message;
  LogoutSuccessState({required this.message});
}

class LogoutErrorState extends AuthState {
  final String message;
  LogoutErrorState({required this.message});
}
