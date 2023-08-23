import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reefer_review_mobile/repositories/utilities/entity_dispatcher.dart';
import '../../data/models/profile/profile.dart';
import '../../data/models/user/user.dart';
import '../../data/post/post.dart';
import '../../data/post/post_with_entity.dart';
import '../../repositories/post_repository.dart/post_repository.dart';
import '../../data/post/post_feed_type.dart';
part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final PostRepository postRepository;
  final EntityDispatcher? entityDispatcher;

  FeedBloc({required this.postRepository, this.entityDispatcher})
      : super(FeedInitial()) {
    on<FetchPostsUsecase>((event, emit) async {
      emit(FeedLoading());
      try {
        var posts = await postRepository.getFeedPosts(
            feedType: event.feedType, user: event.user);
        emit(FeedLoaded(posts));
      } catch (error) {
        emit(FeedError(error.toString()));
      }
    });

    on<ExpandPost>((event, emit) {
      emit(PostExpanded(event.postId));
    });

    on<CollapsePost>((event, emit) {
      emit(PostCollapsed(event.postId));
    });

    on<FetchPostsByAuthor>((event, emit) async {
      emit(FeedLoading());
      try {
        var posts = await postRepository.getPostsByProfileIdAndType(
            event.authorId, event.profileType);
        print('were here righhhhht now');
        emit(FeedLoaded(posts));
      } catch (error) {
        emit(FeedError(error.toString()));
      }
    });

    on<AddPost>((event, emit) async {
      try {
        await postRepository.addPost(event.post);
        var posts = await postRepository.getFeedPosts();
        emit(FeedLoaded(posts));
      } catch (error) {
        emit(FeedError(error.toString()));
      }
    });
  }
}
