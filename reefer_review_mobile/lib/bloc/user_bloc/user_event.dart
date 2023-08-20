part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class FollowBrand extends UserEvent {
  final String userId;
  final int brandId;
  FollowBrand(this.userId, this.brandId);
}

class UnfollowBrand extends UserEvent {
  final String userId;
  final int brandId;
  UnfollowBrand(this.userId, this.brandId);
}
