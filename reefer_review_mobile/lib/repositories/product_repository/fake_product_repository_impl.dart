import 'package:reefer_review_mobile/repositories/product_repository/product_repository.dart';
import 'package:reefer_review_mobile/res/images.dart';

import '../../data/models/product/product.dart';
import '../../data/models/product/product_price.dart';
import '../../data/venue.dart';
import '../venue_repository/fake_venue_repository_impl.dart';

class FakeProductRepository implements ProductRepository {
  List<Product> _allProducts = [];

  static final FakeProductRepository productRepository =
      FakeProductRepository._internal();

  FakeProductRepository._internal() {
    _allProducts = [
      Product(
        productId: 1,
        name: "Wonderful Gummies",
        category: "Edibles",
        strain: "Hybrid",
        brand: "Empire Weed",
        rating: 4.5,
        reviewCount: 10,
        description:
            "These are great. I think. I can keep going and going and going and going and going.",
        image: product1,
        prices: [Price("1g", 14), Price("1/2oz", 5), Price("1/8oz", 2)],
      ),
      Product(
        productId: 2,
        name: "Sample Product 2",
        category: "Edibles",
        strain: "Indica",
        brand: "The Weed Company HQ",
        rating: 3.5,
        reviewCount: 5,
        description: "Tasty treat for relaxing.",
        image: product2,
        prices: [Price("1g", 14), Price("1/2oz", 5), Price("1/8oz", 2)],
      ),
      Product(
        productId: 3,
        name: "Glass Bong",
        category: "Accessories",
        strain: "Sativa",
        brand: "Empire Weed",
        rating: 4.0,
        reviewCount: 7,
        description: "It's got a long neck.",
        image: product3,
        prices: [Price("1g", 14), Price("1/2oz", 5), Price("1/8oz", 2)],
      ),
      Product(
        productId: 4,
        name: "Sample Product 4",
        category: "Concentrates",
        strain: "Hybrid",
        brand: "The Weed Company HQ",
        rating: 5.0,
        reviewCount: 15,
        description: "Powerful concentrate for experienced users.",
        image: product4,
        prices: [Price("1g", 14), Price("1/2oz", 5), Price("1/8oz", 2)],
      ),
      Product(
        productId: 5,
        name: "Sample Product 5",
        category: "Oils",
        strain: "Sativa",
        brand: "Empire Weed",
        rating: 4.2,
        reviewCount: 12,
        description: "Convenient and portable vaping solution.",
        image: product5,
        prices: [Price("1g", 14), Price("1/2oz", 5), Price("1/8oz", 2)],
      ),
    ];
  }

  @override
  Future<List<Product>> getAllProducts() async {
    return _allProducts;
  }

  @override
  Future<Product> getProductById(int id) async {
    return _allProducts.firstWhere((product) => product.productId == id);
  }

  @override
  Future<void> addProduct(Product product) async {
    _allProducts.add(product);
  }

  @override
  Future<void> deleteProduct(int productId) async {
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
  Future<List<Product>> getProductsByBrand(String brandName) async {
    return _allProducts.where((product) => product.brand == brandName).toList();
  }

  @override
  Future<List<Product>> getProductsByVenue(int venueId) async {
    Venue venue =
        await FakeVenueRepository.venueRepository.getVenueById(venueId);

    return _allProducts
        .where((product) => venue.productIds.contains(product.productId))
        .toList();
  }
}
