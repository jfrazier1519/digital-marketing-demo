import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/product.dart';
import '../../presentation/products_screen/category_options_enum.dart';
import '../../presentation/products_screen/sort_options_enum.dart';
import '../../repositories/product_repository/product_repository.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc(this.productRepository) : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
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
  }
}
