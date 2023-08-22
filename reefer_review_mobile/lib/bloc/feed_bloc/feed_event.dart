part of 'feed_bloc.dart';

@immutable
abstract class FeedEvent {}

class FetchPostsUsecase extends FeedEvent {
  final PostFeedType feedType;
  final User user;

  FetchPostsUsecase({required this.feedType, required this.user});
}

class AddPost extends FeedEvent {
  final Post post;
  AddPost(this.post);
}

class ExpandPost extends FeedEvent {
  final String postId;
  ExpandPost(this.postId);
}

class CollapsePost extends FeedEvent {
  final String postId;
  CollapsePost(this.postId);
}

class FetchPostsByAuthor extends FeedEvent {
  final String authorId;

  FetchPostsByAuthor({required this.authorId});
}
