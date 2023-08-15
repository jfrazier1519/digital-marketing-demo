import 'package:reefer_review_mobile/repositories/Brand_repository/brand_repository.dart';
import 'package:reefer_review_mobile/res/images.dart';
import '../../data/models/brand.dart';

class FakeBrandRepository implements BrandRepository {
  List<Brand> _allBrands = [];

  FakeBrandRepository() {
    _allBrands = [
      Brand(
          venueId: 1,
          name: "Sample Brand 1",
          location: "Location A",
          type: "Distillery",
          rating: 4.5,
          reviewCount: 10,
          description: "Very professional establishment.",
          image: venue1),
      Brand(
          venueId: 2,
          name: "Sample Brand 2",
          location: "Location B",
          type: "Bar",
          rating: 3.8,
          reviewCount: 25,
          description:
              "This is a fantastic bar located in Location B. They sell weed in the back",
          image: venue2),
    ];
  }

  @override
  Future<List<Brand>> getAllBrands() async {
    return _allBrands;
  }

  @override
  Future<Brand> getBrandById(int id) async {
    return _allBrands.firstWhere((Brand) => Brand.venueId == id);
  }

  @override
  Future<void> addBrand(Brand Brand) async {
    _allBrands.add(Brand);
  }

  @override
  Future<void> deleteBrand(int BrandId) async {
    _allBrands.removeWhere((Brand) => Brand.venueId == BrandId);
  }

  @override
  Future<void> updateBrand(Brand updatedBrand) async {
    int index =
        _allBrands.indexWhere((Brand) => Brand.venueId == updatedBrand.venueId);
    if (index != -1) {
      _allBrands[index] = updatedBrand;
    }
  }

  @override
  Future<List<Brand>> getBrandsByLocation(String location) async {
    return _allBrands.where((Brand) => Brand.location == location).toList();
  }

  @override
  Future<List<Brand>> sortBrands(String sortOption, bool isAscending,
      [List<Brand>? Brands]) async {
    List<Brand> BrandList = Brands ?? _allBrands;

    Comparator<Brand> comparator;

    switch (sortOption) {
      case 'Brand':
        comparator = (a, b) => a.name.compareTo(b.name);
        break;
      case 'Type':
        comparator = (a, b) => a.type.compareTo(b.type);
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

    BrandList.sort(
        (a, b) => isAscending ? comparator(a, b) : -comparator(a, b));

    return BrandList;
  }
}
