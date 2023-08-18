part of 'brand_bloc.dart';

@immutable
abstract class BrandState {}

class BrandInitial extends BrandState {}

class BrandLoading extends BrandState {}

class BrandsLoaded extends BrandState {
  final List<Brand> brands;

  BrandsLoaded(this.brands);
}
