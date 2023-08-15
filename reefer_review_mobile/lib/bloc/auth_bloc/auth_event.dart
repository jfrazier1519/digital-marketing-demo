part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginUserUsecase extends AuthEvent {
  final LoginUserRequest request;

  LoginUserUsecase(this.request);
}

class LogoutUserUsecase extends AuthEvent {}
