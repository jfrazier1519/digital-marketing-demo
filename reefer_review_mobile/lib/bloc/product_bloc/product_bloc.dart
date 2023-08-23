import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/models/product/product.dart';
import '../../presentation/products_screen/products_category_enum.dart';
import '../../presentation/products_screen/products_sort_enum.dart';
import '../../repositories/product_repository/product_repository.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc(this.productRepository) : super(ProductInitial()) {
    on<FetchProductsUsecase>((event, emit) async {
      emit(ProductLoading());
      var products = await productRepository.getAllProducts();
      emit(ProductsLoaded(products));
    });

    on<FilterByCategory>((event, emit) async {
      emit(ProductLoading());
      var products = await productRepository
          .getProductsByCategory(event.category.toString().split('.').last);
      emit(ProductsLoaded(products));
    });

    on<SortProducts>((event, emit) async {
      emit(ProductLoading());

      List<Product> products = event.category != null
          ? await productRepository
              .getProductsByCategory(event.category!.toString().split('.').last)
          : await productRepository.getAllProducts();

      products = await productRepository.sortProducts(
          event.sortOption.toString().split('.').last,
          event.isAscending,
          products);

      emit(ProductsLoaded(products));
    });

    on<FetchProductsByBrand>((event, emit) async {
      emit(ProductLoading());
      var products = await productRepository.getProductsByBrand(event.brand);
      emit(ProductsLoaded(products));
    });

    on<FetchProductsByVenue>((event, emit) async {
      emit(ProductLoading());
      var products = await productRepository.getProductsByVenue(event.venueId);
      emit(ProductsLoaded(products));
    });

    on<FetchProductsById>((event, emit) async {
      emit(ProductLoading());
      var product = await productRepository.getProductById(event.productId);
      emit(ProductLoaded(product));
    });
  }
}
