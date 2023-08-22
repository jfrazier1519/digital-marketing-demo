part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class RegisterUserUsecase extends UserEvent {
  final RegisterUserRequest request;

  RegisterUserUsecase(this.request);
}

class SendEmailVerifcationLinkUseCase extends UserEvent {
  final SendEmailVerifcationLinkRequest request;

  SendEmailVerifcationLinkUseCase(this.request);
}

class UpdateUserprofileUsecase extends UserEvent {
  final UpdateProfileRequest request;

  UpdateUserprofileUsecase(this.request);
}

class LogoutUserUsecase extends UserEvent {}

class LoginUserUsecase extends UserEvent {
  final LoginUserRequest request;

  LoginUserUsecase(this.request);
}

class ToggleFollowBrand extends UserEvent {
  final User user;
  final int brandId;

  ToggleFollowBrand(this.user, this.brandId);
}
