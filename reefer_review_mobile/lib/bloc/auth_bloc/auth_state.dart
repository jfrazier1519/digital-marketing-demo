part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthUserLoggedIn extends AuthState {
  final User user;

  AuthUserLoggedIn(this.user);
}
