import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/models/review/review.dart';
import '../../repositories/review_repository/review_repository.dart';
part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewRepository reviewRepository;

  ReviewBloc(this.reviewRepository) : super(ReviewInitial()) {
    on<FetchReviewsForProduct>((event, emit) async {
      emit(ReviewLoading());
      var reviews =
          await reviewRepository.getAllReviewsForProduct(event.productId);
      emit(ReviewsLoaded(reviews));
    });

    on<FetchReviewsForVenue>((event, emit) async {
      emit(ReviewLoading());
      var reviews = await reviewRepository.getAllReviewsForVenue(event.venueId);
      emit(ReviewsLoaded(reviews));
    });

    on<ExpandReview>((event, emit) {
      emit(ReviewExpanded(event.reviewId));
    });

    on<CollapseReview>((event, emit) {
      emit(ReviewCollapsed(event.reviewId));
    });
  }
}
