import 'package:reefer_review_mobile/res/images.dart';
import '../../data/models/brand.dart';
import '../../presentation/brands_screen/brands_category_enum.dart';
import 'brand_repository.dart';

class FakeBrandRepository implements BrandRepository {
  List<Brand> _allBrands = [];

  FakeBrandRepository() {
    _allBrands = [
      Brand(
          brandId: 1,
          name: "The Weed Company HQ",
          rating: 4.5,
          reviewCount: 10,
          description: "How very weedy it sounds.",
          image: brand1,
          categories: [
            BrandsCategoryEnum.Accessories,
            BrandsCategoryEnum.Concentrates,
          ]),
      Brand(
          brandId: 2,
          name: "Empire Weed",
          rating: 3.8,
          reviewCount: 25,
          description: "The empire strikes back.",
          image: brand2,
          categories: [
            BrandsCategoryEnum.Concentrates,
            BrandsCategoryEnum.Merch,
            BrandsCategoryEnum.Flower
          ]),
    ];
  }

  @override
  Future<List<Brand>> getAllBrands() async {
    return _allBrands;
  }

  @override
  Future<Brand> getBrandById(int id) async {
    return _allBrands.firstWhere((brand) => brand.brandId == id);
  }

  @override
  Future<void> addBrand(Brand brand) async {
    _allBrands.add(brand);
  }

  @override
  Future<void> deleteBrand(int brandId) async {
    _allBrands.removeWhere((brand) => brand.brandId == brandId);
  }

  @override
  Future<void> updateBrand(Brand updatedBrand) async {
    int index =
        _allBrands.indexWhere((brand) => brand.brandId == updatedBrand.brandId);
    if (index != -1) {
      _allBrands[index] = updatedBrand;
    }
  }

  BrandsCategoryEnum getCategoryEnum(String category) {
    return BrandsCategoryEnum.values.firstWhere(
      (e) => e.toString().split('.').last == category,
      orElse: () =>
          throw ArgumentError('The provided string is not a valid category.'),
    );
  }

  @override
  Future<List<Brand>> getBrandsByCategory(String category) async {
    var categoryEnum = getCategoryEnum(category);
    return _allBrands
        .where((brand) => brand.categories.contains(categoryEnum))
        .toList();
  }

  @override
  Future<List<Brand>> sortBrands(String sortOption, bool isAscending,
      [List<Brand>? brands]) async {
    List<Brand> brandList = brands ?? _allBrands;

    Comparator<Brand> comparator;

    switch (sortOption) {
      case 'Brand':
        comparator = (a, b) => a.name.compareTo(b.name);
        break;
      case 'Rating':
        comparator = (a, b) => a.rating.compareTo(b.rating);
        break;
      case 'Reviews':
        comparator = (a, b) => a.reviewCount.compareTo(b.reviewCount);
        break;
      default:
        comparator = (a, b) => a.name.compareTo(b.name);
        break;
    }

    brandList
        .sort((a, b) => isAscending ? comparator(a, b) : -comparator(a, b));

    return brandList;
  }
}
