part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class FetchProducts extends ProductEvent {}

class FilterByCategory extends ProductEvent {
  final CategoryOptionsEnum category;
  FilterByCategory(this.category);
}

class SortProducts extends ProductEvent {
  final CategoryOptionsEnum? category;
  final SortOptionsEnum sortOption;
  final bool isAscending;

  SortProducts(
      {this.category, required this.sortOption, required this.isAscending});
}
