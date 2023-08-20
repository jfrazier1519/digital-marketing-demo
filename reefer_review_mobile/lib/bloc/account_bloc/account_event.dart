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

class UpdateProfileUsecase extends AccountEvent {
  final UpdateProfileRequest request;

  UpdateProfileUsecase(this.request);
}

class GetAccountUsecase extends AccountEvent {
  final GetAccountRequest? request;

  GetAccountUsecase({this.request});
}
