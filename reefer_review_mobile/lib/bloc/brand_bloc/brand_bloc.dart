import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/models/brand.dart';
import '../../presentation/brands_screen/brands_category_enum.dart';
import '../../presentation/brands_screen/brands_sort_enum.dart';
import '../../repositories/brand_repository/brand_repository.dart';
part 'brand_event.dart';
part 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  final BrandRepository brandRepository;

  BrandBloc(this.brandRepository) : super(BrandInitial()) {
    on<FetchBrands>((event, emit) async {
      emit(BrandLoading());
      var brands = await brandRepository.getAllBrands();
      emit(BrandsLoaded(brands));
    });

    on<FilterByCategory>((event, emit) async {
      emit(BrandLoading());
      var brands = await brandRepository
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
  }
}
