part of 'account_bloc.dart';

@immutable
abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountRequestSuccessful extends AccountState {}

class UserNotFound extends AccountState {}

class UserDetailsFetched extends AccountState {
  final User user;

  UserDetailsFetched(this.user);
}
