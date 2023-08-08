part of 'feed_bloc.dart';

@immutable
abstract class FeedState {}

class FeedInitial extends FeedState {}

class FeedLoading extends FeedState {}

class FeedLoaded extends FeedState {
  final List<Post> posts;

  FeedLoaded(this.posts);
}

class PostExpanded extends FeedState {
  final int postId;
  PostExpanded(this.postId);
}

class PostCollapsed extends FeedState {
  final int postId;
  PostCollapsed(this.postId);
}
