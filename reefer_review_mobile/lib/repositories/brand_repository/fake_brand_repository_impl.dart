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
        name: "Makerz",
        rating: 3.6,
        reviewCount: 22,
        description:
            "The best concentrates, tinktures, and wax you can find. Homgrown with both care and hard won knowledge.",
        image: brandID1,
        categories: [
          ProductsCategoryEnum.Tincture,
          ProductsCategoryEnum.Oils,
          ProductsCategoryEnum.Wax,
          ProductsCategoryEnum.Dab,
          ProductsCategoryEnum.Concentrates
        ],
        venueIds: [
          "3"
        ]),
    Brand(
        uid: "2",
        name: "Munchies Munchables",
        rating: 4.2,
        reviewCount: 78,
        description:
            "Need to take the edge off? Not big into the idea of smoking? Why not try Munchies Munchables?! We provide all kinds of things from Cbd gummies to 100 or even 1000 mg chocolates. Come see what we Munchies has to offer today!",
        image: brandID2,
        categories: [
          ProductsCategoryEnum.Edibles,
        ],
        venueIds: [
          "2"
        ]),
    Brand(
        uid: "3",
        name: "GreenThumb",
        rating: 5,
        reviewCount: 1026,
        description:
            "We cultivate and produce top quality Flower, and we have the thumbs to prove it!",
        image: brandID3,
        categories: [
          ProductsCategoryEnum.Flower,
        ],
        venueIds: [
          "2",
          "3"
        ]),
    Brand(
        uid: "4",
        name: "FlwrPwr",
        rating: 4.7,
        reviewCount: 617,
        description:
            "Our belief is that the quality of your tools affects the qulaity of your goods. Get the best from your Flower with FlwrPwr Glass and accessories. You wont find a better deal on E-nails, Rigs, and other Glass anywhere.",
        image: brandID4,
        categories: [
          ProductsCategoryEnum.Accessories,
        ],
        venueIds: [
          "1"
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
