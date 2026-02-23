import 'package:ecommerce_prueba/src/domain/repository/ProductRepository.dart';

class GetProductsSearchUseCase {
  ProductRepository productRepository;
  GetProductsSearchUseCase(this.productRepository);
  run(String query) => productRepository.getProductsSearch(query);
}
