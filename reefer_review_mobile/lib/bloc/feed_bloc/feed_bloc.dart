import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/post/post.dart';
import '../../repositories/post_repository.dart/post_repository.dart';
import '../../data/post/post_feed_type.dart';
part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final PostRepository postRepository;

  FeedBloc(this.postRepository) : super(FeedInitial()) {
    on<FetchPostsUsecase>((event, emit) async {
      emit(FeedLoading());
      var posts = await postRepository.getPosts(feedType: event.feedType);
      emit(FeedLoaded(posts));
    });

    on<ExpandPost>((event, emit) {
      emit(PostExpanded(event.postId));
    });

    on<CollapsePost>((event, emit) {
      emit(PostCollapsed(event.postId));
    });

    on<AddPost>((event, emit) async {
      await postRepository.addPost(event.post);
      var posts = await postRepository.getPosts();
      emit(FeedLoaded(posts));
    });

    on<FetchPostsByAuthor>((event, emit) async {
      emit(FeedLoading());
      var posts = await postRepository.getPostsByAuthor(event.author);
      emit(FeedLoaded(posts));
    });
  }
}
