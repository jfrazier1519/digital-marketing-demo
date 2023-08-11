import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/product.dart';
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
  }
}
