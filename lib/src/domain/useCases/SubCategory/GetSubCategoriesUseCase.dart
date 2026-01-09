import 'package:ecommerce_prueba/src/domain/repository/SubCategoryRepository.dart';

class GetSubCategoriesUseCase {
  SubCategoryRepository subCategoryRepository;
  GetSubCategoriesUseCase(this.subCategoryRepository);
  run() => subCategoryRepository.getSubCategories();
}
