import 'package:reefer_review_mobile/res/images.dart';
import '../../data/models/brand/brand.dart';
import '../../presentation/products_screen/products_category_enum.dart';
import '../utilities/custom_entity_exception.dart';
import 'brand_repository.dart';

class FakeBrandRepository implements BrandRepository {
  static BrandRepository repository = FakeBrandRepository._internal();

  FakeBrandRepository._internal();

  final List<Brand> _allBrands = [
    Brand(
        uid: "1",
        name: "The Weed Company HQ",
        rating: 4.5,
        reviewCount: 10,
        description: "How very weedy it sounds.",
        image: brand1,
        categories: [
          ProductsCategoryEnum.Accessories,
          ProductsCategoryEnum.Edibles,
        ],
        venueIds: [
          "1"
        ]),
    Brand(
        uid: "2",
        name: "Empire Weed",
        rating: 3.8,
        reviewCount: 25,
        description: "The empire strikes back.",
        image: brand2,
        categories: [
          ProductsCategoryEnum.CBD,
          ProductsCategoryEnum.Merch,
          ProductsCategoryEnum.Flower
        ],
        venueIds: [
          "2"
        ]),
  ];

  @override
  Future<List<Brand>> getAllBrands() async {
    return _allBrands;
  }

  @override
  Future<Brand> getBrandById(String brandId) async {
    print('All brands: $_allBrands');
    try {
      return _allBrands.firstWhere((brand) => brand.uid == brandId);
    } catch (_) {
      throw EntityNotFoundException('Brand with id $brandId not found');
    }
  }

  @override
  Future<void> addBrand(Brand brand) async {
    _allBrands.add(brand);
  }

  @override
  Future<void> deleteBrand(String brandId) async {
    _allBrands.removeWhere((brand) => brand.uid == brandId);
  }

  @override
  Future<void> updateBrand(Brand updatedBrand) async {
    int index = _allBrands.indexWhere((brand) => brand.uid == updatedBrand.uid);
    if (index != -1) {
      _allBrands[index] = updatedBrand;
    }
  }

  ProductsCategoryEnum getCategoryEnum(String category) {
    return ProductsCategoryEnum.values.firstWhere(
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
        comparator = (a, b) => a.profileName!.compareTo(b.profileName!);
        break;
      case 'Rating':
        comparator = (a, b) => a.rating.compareTo(b.rating);
        break;
      case 'Reviews':
        comparator = (a, b) => a.reviewCount.compareTo(b.reviewCount);
        break;
      default:
        comparator = (a, b) => a.profileName!.compareTo(b.profileName!);
        break;
    }

    brandList
        .sort((a, b) => isAscending ? comparator(a, b) : -comparator(a, b));

    return brandList;
  }
}
