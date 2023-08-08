part of 'feed_bloc.dart';

@immutable
abstract class FeedEvent {}

class FetchPostsUsecase extends FeedEvent {
  final PostFeedType feedType;

  FetchPostsUsecase(this.feedType);
}
