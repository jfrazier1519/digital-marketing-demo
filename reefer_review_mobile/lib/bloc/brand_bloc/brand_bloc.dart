import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reefer_review_mobile/repositories/venue_repository/venue_repository.dart';
import '../../data/models/brand/brand.dart';
import '../../data/models/venue/venue.dart';
import '../../presentation/brands_screen/brands_sort_enum.dart';
import '../../presentation/products_screen/products_category_enum.dart';
import '../../repositories/brand_repository/brand_repository.dart';
part 'brand_event.dart';
part 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  final BrandRepository brandRepository;
  final VenueRepository? venueRepository;

  BrandBloc(this.brandRepository, [this.venueRepository])
      : super(BrandInitial()) {
    on<FetchBrands>((event, emit) async {
      emit(BrandLoading());
      List<Brand> brands = await brandRepository.getAllBrands();
      emit(BrandsLoaded(brands));
    });

    on<FilterByCategory>((event, emit) async {
      emit(BrandLoading());
      List<Brand> brands = await brandRepository
          .getBrandsByCategory(event.category.toString().split('.').last);
      emit(BrandsLoaded(brands));
    });

    on<SortBrands>((event, emit) async {
      emit(BrandLoading());
      List<Brand> brands = event.category != null
          ? await brandRepository
              .getBrandsByCategory(event.category!.toString().split('.').last)
          : await brandRepository.getAllBrands();

      brands = await brandRepository.sortBrands(
          event.sortOption.toString().split('.').last,
          event.isAscending,
          brands);

      emit(BrandsLoaded(brands));
    });

    on<FetchAssociatedVenues>((event, emit) async {
      emit(BrandLoading());

      if (venueRepository == null) {
        throw Exception('VenueRepository is not initialized.');
      }

      Brand brand = await brandRepository.getBrandById(event.brandId);
      List<Venue> associatedVenues = await Future.wait(brand.venueIds
          .map((venueId) => venueRepository!.getVenueById(venueId)));

      emit(AssociatedVenuesLoaded(brand, associatedVenues));
    });
  }
}
