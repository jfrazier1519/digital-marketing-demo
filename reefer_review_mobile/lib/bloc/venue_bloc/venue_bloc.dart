import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/venue.dart';
import '../../presentation/venue_screen/sort_options_enum.dart';
import '../../repositories/venue_repository/venue_repository.dart'; // Create a venue repository similar to the product_repository
part 'venue_event.dart';
part 'venue_state.dart';

class VenueBloc extends Bloc<VenueEvent, VenueState> {
  final VenueRepository venueRepository;

  VenueBloc(this.venueRepository) : super(VenueInitial()) {
    on<FetchVenues>((event, emit) async {
      emit(VenueLoading());
      var venues = await venueRepository.getAllVenues();
      emit(VenuesLoaded(venues));
    });

    on<SortVenues>((event, emit) async {
      emit(VenueLoading());

      List<Venue> venues = await venueRepository.getAllVenues();

      venues = await venueRepository.sortVenues(
          event.sortOption.toString().split('.').last,
          event.isAscending,
          venues);

      emit(VenuesLoaded(venues));
    });
  }
}
