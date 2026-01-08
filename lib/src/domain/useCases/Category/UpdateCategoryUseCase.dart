import 'package:ecommerce_prueba/src/domain/models/Category.dart';
import 'package:ecommerce_prueba/src/domain/repository/CategoryRepository.dart';

class UpdateCategoryUseCase {
  CategoryRepository categoryRepository;
  UpdateCategoryUseCase(this.categoryRepository);
  run(Category category, String id) => categoryRepository.update(category, id);
}
