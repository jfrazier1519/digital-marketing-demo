import '../../data/models/product/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getAllProducts();
  Future<List<Product>> getProductsByCategory(String category);
  Future<List<Product>> getProductsByBrand(String brandId);
  Future<List<Product>> getProductsByVenue(String venueId);
  Future<List<Product>> sortProducts(
      String sortOption, bool isAscending, List<Product> products);
  Future<Product> getProductById(String id);
  Future<void> addProduct(Product product);
  Future<void> updateProduct(Product product);
  Future<void> deleteProduct(String productId);
}
