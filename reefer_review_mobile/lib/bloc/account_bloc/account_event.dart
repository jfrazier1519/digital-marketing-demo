part of 'account_bloc.dart';

@immutable
abstract class AccountEvent {}

class RegisterUserUseCase extends AccountEvent {
  final RegisterUserRequest request;

  RegisterUserUseCase(this.request);
}

class SendEmailVerifcationLinkUseCase extends AccountEvent {
  final SendEmailVerifcationLinkRequest request;

  SendEmailVerifcationLinkUseCase(this.request);
}

class FetchUserDetails extends AccountEvent {
  final String userId;

  FetchUserDetails(this.userId);
}
