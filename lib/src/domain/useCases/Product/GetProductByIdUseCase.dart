import 'package:ecommerce_prueba/src/domain/repository/ProductRepository.dart';

class GetProductByIdUaseCase {
  ProductRepository productRepository;
  GetProductByIdUaseCase(this.productRepository);
  run(String id) => productRepository.getProductById(id);
}
