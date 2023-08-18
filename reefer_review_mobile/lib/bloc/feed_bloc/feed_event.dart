part of 'feed_bloc.dart';

@immutable
abstract class FeedEvent {}

class FetchPostsUsecase extends FeedEvent {
  final PostFeedType feedType;

  FetchPostsUsecase(this.feedType);
}

class ExpandPost extends FeedEvent {
  final int postId;
  ExpandPost(this.postId);
}

class CollapsePost extends FeedEvent {
  final int postId;
  CollapsePost(this.postId);
}

class FetchPostsByAuthor extends FeedEvent {
  final String author;

  FetchPostsByAuthor({required this.author});
}
