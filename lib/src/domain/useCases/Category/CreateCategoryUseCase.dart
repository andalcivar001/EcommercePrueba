import 'package:ecommerce_prueba/src/domain/models/Category.dart';
import 'package:ecommerce_prueba/src/domain/repository/CategoryRepository.dart';

class CreateCategoryUseCase {
  CategoryRepository categoryRepository;
  CreateCategoryUseCase(this.categoryRepository);
  run(Category category) => categoryRepository.create(category);
}
