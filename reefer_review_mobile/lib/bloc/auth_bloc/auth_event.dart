part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginUserUsecase extends AuthEvent {
  final String email;
  final String password;

  LoginUserUsecase(this.email, this.password);
}
