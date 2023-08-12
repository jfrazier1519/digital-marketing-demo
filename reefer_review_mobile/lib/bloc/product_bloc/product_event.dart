part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class FetchProducts extends ProductEvent {}

class FilterByCategory extends ProductEvent {
  final String category;
  FilterByCategory(this.category);
}

class SortProducts extends ProductEvent {
  final String? category;
  final String sortOption;
  final bool isAscending;

  SortProducts(
      {this.category, required this.sortOption, required this.isAscending});
}
