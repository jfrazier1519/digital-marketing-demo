part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserUpdated extends UserState {
  final User user;
  UserUpdated(this.user);
}

class UserRequestSuccessful extends UserState {
  UserRequestSuccessful();
}

class UserLoaded extends UserState {
  final User account;

  UserLoaded(this.account);
}
