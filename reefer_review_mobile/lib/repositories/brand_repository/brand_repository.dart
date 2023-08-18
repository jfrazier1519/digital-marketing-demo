import '../../data/models/brand.dart';

abstract class BrandRepository {
  Future<List<Brand>> getAllBrands();
  Future<List<Brand>> getBrandsByCategory(String category);
  Future<List<Brand>> sortBrands(
      String sortOption, bool isAscending, List<Brand> brands);
  Future<Brand> getBrandById(int id);
  Future<void> addBrand(Brand brand);
  Future<void> updateBrand(Brand brand);
  Future<void> deleteBrand(int brandId);
}
