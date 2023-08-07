part of 'feed_bloc.dart';

@immutable
sealed class FeedState {}

final class FeedInitial extends FeedState {}

//LoadingState

//LoadedState => array of posts