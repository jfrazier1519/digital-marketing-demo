part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class GetProfileByIdUsecase extends ProfileEvent {
  final GetProfileByIdRequest request;

  GetProfileByIdUsecase(this.request);
}
