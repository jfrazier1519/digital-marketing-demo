part of 'feed_bloc.dart';

@immutable
abstract class FeedEvent {}

class FetchPostsUsecase extends FeedEvent {
  final PostFeedType feedType;

  FetchPostsUsecase(this.feedType);
}

class AddPost extends FeedEvent {
  final Post post;
  AddPost(this.post);
}

class ExpandPost extends FeedEvent {
  final int postId;
  ExpandPost(this.postId);
}

class CollapsePost extends FeedEvent {
  final int postId;
  CollapsePost(this.postId);
}
