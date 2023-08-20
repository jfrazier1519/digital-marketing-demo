// Inside user_event.dart

part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class ToggleFollowBrand extends UserEvent {
  final String userId;
  final int brandId;

  ToggleFollowBrand(this.userId, this.brandId);
}
