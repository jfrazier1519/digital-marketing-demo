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

class LogoutUserUsecase extends AccountEvent {}

class LoginUserUsecase extends AccountEvent {
  final LoginUserRequest request;

  LoginUserUsecase(this.request);
}
