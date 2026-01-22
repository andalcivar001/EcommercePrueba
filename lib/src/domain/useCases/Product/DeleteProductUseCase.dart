import 'package:ecommerce_prueba/src/domain/repository/ProductRepository.dart';

class DeleteProductUseCase {
  final ProductRepository repository;

  DeleteProductUseCase(this.repository);

  run(String id) => repository.delete(id);
}
