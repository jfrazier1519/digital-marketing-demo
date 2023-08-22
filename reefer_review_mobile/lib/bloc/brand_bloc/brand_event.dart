part of 'brand_bloc.dart';

@immutable
abstract class BrandEvent {}

class FetchBrands extends BrandEvent {}

class FilterByCategory extends BrandEvent {
  final ProductsCategoryEnum category;
  FilterByCategory(this.category);
}

class SortBrands extends BrandEvent {
  final ProductsCategoryEnum? category;
  final BrandsSortEnum sortOption;
  final bool isAscending;

  SortBrands(
      {this.category, required this.sortOption, required this.isAscending});
}

class FetchAssociatedVenues extends BrandEvent {
  final String brandId;
  FetchAssociatedVenues(this.brandId);
}
