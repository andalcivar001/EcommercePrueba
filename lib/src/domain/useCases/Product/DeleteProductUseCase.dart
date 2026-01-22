import 'package:ecommerce_prueba/src/domain/repository/ProductRepository.dart';

class DeleteProductUseCase {
  ProductRepository productRepository;
  DeleteProductUseCase(this.productRepository);
  run(String id) => productRepository.delete(id);
}
