import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/models/venue/venue.dart';
import '../../data/models/brand/brand.dart';
import '../../presentation/venue_screen/venues_sort_enum.dart';
import '../../repositories/venue_repository/venue_repository.dart';
import '../../repositories/brand_repository/brand_repository.dart';
part 'venue_event.dart';
part 'venue_state.dart';

class VenueBloc extends Bloc<VenueEvent, VenueState> {
  final VenueRepository venueRepository;
  final BrandRepository? brandRepository;

  VenueBloc(this.venueRepository, [this.brandRepository])
      : super(VenueInitial()) {
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

    on<FetchAssociatedBrands>((event, emit) async {
      emit(VenueLoading());
      if (brandRepository == null) {
        throw Exception('BrandRepository is not initialized.');
      }
      Venue venue = await venueRepository.getVenueById(event.venueId);
      List<Brand> associatedBrands = await Future.wait(venue.brandIds
          .map((brandId) => brandRepository!.getBrandById(brandId)));
      emit(AssociatedBrandsLoaded(venue, associatedBrands));
    });
  }
}
