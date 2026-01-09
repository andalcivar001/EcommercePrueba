import 'package:ecommerce_prueba/src/domain/repository/CategoryRepository.dart';

class DeleteCategoryUseCase {
  CategoryRepository categoryRepository;
  DeleteCategoryUseCase(this.categoryRepository);
  run(String id) => categoryRepository.delete(id);
}
