part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class FetchProducts extends ProductEvent {}

class FilterByCategory extends ProductEvent {
  final ProductsCategoryEnum category;
  FilterByCategory(this.category);
}

class SortProducts extends ProductEvent {
  final ProductsCategoryEnum? category;
  final ProductsSortEnum sortOption;
  final bool isAscending;

  SortProducts(
      {this.category, required this.sortOption, required this.isAscending});
}
