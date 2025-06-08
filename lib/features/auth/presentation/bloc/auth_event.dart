part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class RegisterEvent extends AuthEvent {
  final Map<String, dynamic> userData;
  RegisterEvent({required this.userData});
}
