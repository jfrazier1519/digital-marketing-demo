part of 'brand_bloc.dart';

@immutable
abstract class BrandEvent {}

class FetchBrands extends BrandEvent {}

class FilterByCategory extends BrandEvent {
  final BrandsCategoryEnum category;
  FilterByCategory(this.category);
}

class SortBrands extends BrandEvent {
  final BrandsCategoryEnum? category;
  final BrandsSortEnum sortOption;
  final bool isAscending;

  SortBrands(
      {this.category, required this.sortOption, required this.isAscending});
}
