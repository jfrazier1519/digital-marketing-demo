part of 'account_bloc.dart';

@immutable
abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountRequestSuccessful extends AccountState {
  AccountRequestSuccessful();
}

class AccountLoaded extends AccountState {
  final Account account;

  AccountLoaded(this.account);
}
