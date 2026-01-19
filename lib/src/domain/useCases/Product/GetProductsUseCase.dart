import 'package:ecommerce_prueba/src/domain/repository/ProductRepository.dart';

class GetProductUseCase {
  ProductRepository productRepository;
  GetProductUseCase(this.productRepository);
  run() => productRepository.getProducts();
}
