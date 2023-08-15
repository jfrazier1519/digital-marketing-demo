import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/models/brand.dart';
import '../../presentation/Brands_screen/Brands_category_enum.dart';
import '../../presentation/Brands_screen/Brands_sort_enum.dart';
import '../../repositories/brand_repository/brand_repository.dart';
part 'brand_event.dart';
part 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  final BrandRepository brandRepository;

  BrandBloc(this.brandRepository) : super(BrandInitial()) {
    on<FetchBrands>((event, emit) async {
      emit(BrandLoading());
      var brands = await BrandRepository.getAllBrands();
      emit(BrandsLoaded(brands));
    });

    on<FilterByCategory>((event, emit) async {
      emit(BrandLoading());
      var Brands = await BrandRepository.getBrandsByCategory(
          event.category.toString().split('.').last);
      emit(BrandsLoaded(Brands));
    });

    on<SortBrands>((event, emit) async {
      emit(BrandLoading());

      List<Brand> brands = event.category != null
          ? await BrandRepository.getBrandsByCategory(
              event.category!.toString().split('.').last)
          : await BrandRepository.getAllBrands();

      brands = await BrandRepository.sortBrands(
          event.sortOption.toString().split('.').last,
          event.isAscending,
          brands);

      emit(BrandsLoaded(brands));
    });
  }
}
