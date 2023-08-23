import 'package:reefer_review_mobile/repositories/product_repository/product_repository.dart';
import 'package:reefer_review_mobile/res/images.dart';

import '../../data/models/product/product.dart';
import '../../data/models/product/product_price.dart';
import '../../data/models/venue/venue.dart';
import '../venue_repository/fake_venue_repository_impl.dart';

class FakeProductRepository implements ProductRepository {
  List<Product> _allProducts = [];

  static final FakeProductRepository productRepository =
      FakeProductRepository._internal();

//TODO: change category from string to enum. Same with brand and venue names
  FakeProductRepository._internal() {
    _allProducts = [
      Product(
        productId: '1',
        name: "Sour Tangie",
        category: 'Flower',
        brand: "GreenThumb",
        rating: 4.6,
        reviewCount: 20,
        description: "Sativa",
        image: productID1,
        prices: [Price("1g", 20), Price("1/8oz", 60)],
      ),
      Product(
        productId: '2',
        name: "Grape Ape",
        category: "Flower",
        brand: "GreenThumb",
        rating: 4.3,
        reviewCount: 15,
        description: "Indica",
        image: productID2,
        prices: [Price("1g", 15), Price("1/8oz", 40), Price("1/2oz", 160)],
      ),
      Product(
        productId: '3',
        name: "Sherb Crasher",
        category: "Flower",
        brand: "GreenThumb",
        rating: 4.0,
        reviewCount: 84,
        description: "Sativa Dominant Hybrid",
        image: productID3,
        prices: [Price("1g", 25), Price("1/8oz", 60), Price("1/2oz", 230)],
      ),
      Product(
        productId: '4',
        name: "Durban Poison",
        category: "PreRoll",
        brand: "GreenThumb",
        rating: 5.0,
        reviewCount: 16,
        description: "Indica Dominant Hybrid",
        image: productID4,
        prices: [Price(".5g", 20), Price("1g", 40)],
      ),
      Product(
        productId: '5',
        name: "Wedding Cake",
        category: "Tincture",
        brand: "Makerz",
        rating: 3.6,
        reviewCount: 12,
        description: "Sativa Dominant Hybrid",
        image: productID5,
        prices: [Price("100ml", 50)],
      ),
      Product(
        productId: '6',
        name: "Schmekle",
        category: "Dab",
        brand: "Makerz",
        rating: 3.2,
        reviewCount: 7,
        description: "Sativa",
        image: productID6,
        prices: [Price("1g", 30)],
      ),
      Product(
        productId: '7',
        name: "StarWalker",
        category: "Dab",
        brand: "Makerz",
        rating: 5,
        reviewCount: 6,
        description: "Indica",
        image: productID7,
        prices: [Price(".5g", 30), Price("1g", 50)],
      ),
      Product(
        productId: '8',
        name: "Breaker Bar",
        category: "Edibles",
        brand: "Munchies Munchables",
        rating: 3.2,
        reviewCount: 90,
        description: "1000mg Chocolate Bar",
        image: productID8,
        prices: [Price("1000mg", 50)],
      ),
      Product(
        productId: '9',
        name: "Fruit Bear",
        category: "Edibles",
        brand: "Munchies Munchables",
        rating: 5,
        reviewCount: 8,
        description: "Gummy bearks 25mg CBD each",
        image: productID9,
        prices: [Price("10 piece", 15)],
      ),
      Product(
        productId: '10',
        name: "Mama's Kitchen",
        category: "Edibles",
        brand: "Munchies Munchables",
        rating: 4.3,
        reviewCount: 12,
        description: "Brownie 30mg, 100mg",
        image: productID10,
        prices: [Price("30mg", 15), Price("100mg", 40)],
      ),
      Product(
        productId: '11',
        name: "Blue Splash Bong",
        category: "Accessories",
        brand: "FlwrPwr",
        rating: 4.5,
        reviewCount: 2,
        description: "Bong",
        image: productID11,
        prices: [Price("1", 100)],
      ),
      Product(
        productId: '12',
        name: "Bronze Pipe",
        category: "Accessories",
        brand: "FlwrPwr",
        rating: 4.7,
        reviewCount: 5,
        description: "Pipe",
        image: productID12,
        prices: [Price("1", 30)],
      ),
      Product(
        productId: '13',
        name: "Honeycomb Rig",
        category: "Accessories",
        brand: "FlwrPwr",
        rating: 5,
        reviewCount: 1,
        description: "Dab Rig",
        image: productID13,
        prices: [Price("1", 220)],
      ),
      Product(
        productId: '14',
        name: "Atomizer Pen",
        category: "Edibles",
        brand: "FlwrPwr",
        rating: 2.6,
        reviewCount: 15,
        description: "Atomizer for Flower",
        image: productID14,
        prices: [Price("1", 120)],
      ),
    ];
  }

  @override
  Future<List<Product>> getAllProducts() async {
    return _allProducts;
  }

  @override
  Future<Product> getProductById(String productId) async {
    return _allProducts.firstWhere((product) => product.productId == productId);
  }

  @override
  Future<void> addProduct(Product product) async {
    _allProducts.add(product);
  }

  @override
  Future<void> deleteProduct(String productId) async {
    _allProducts.removeWhere((product) => product.productId == productId);
  }

  @override
  Future<void> updateProduct(Product updatedProduct) async {
    int index = _allProducts
        .indexWhere((product) => product.productId == updatedProduct.productId);
    if (index != -1) {
      _allProducts[index] = updatedProduct;
    }
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    return _allProducts
        .where((product) => product.category == category)
        .toList();
  }

  @override
  Future<List<Product>> sortProducts(String sortOption, bool isAscending,
      [List<Product>? products]) async {
    List<Product> productList = products ?? _allProducts;

    Comparator<Product> comparator;

    switch (sortOption) {
      case 'Product':
        comparator = (a, b) => a.name.compareTo(b.name);
        break;
      case 'Brand':
        comparator = (a, b) => a.brand.compareTo(b.brand);
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

    productList.sort((a, b) {
      if (isAscending) {
        return comparator(a, b);
      } else {
        return comparator(b, a);
      }
    });

    return productList;
  }

  @override
  Future<List<Product>> getProductsByBrand(String brandId) async {
    return _allProducts.where((product) => product.brand == brandId).toList();
  }

  @override
  Future<List<Product>> getProductsByVenue(String venueId) async {
    Venue venue = await FakeVenueRepository.repository.getVenueById(venueId);
    print('Fetched Venue: $venue'); // Add this line to debug

    return _allProducts
        .where((product) => venue.productIds.contains(product.productId))
        .toList();
  }
}
