import 'package:ecommerce_prueba/src/domain/models/SubCategory.dart';
import 'package:ecommerce_prueba/src/domain/repository/SubCategoryRepository.dart';

class CreateSubCategoryUseCase {
  SubCategoryRepository subCategoryRepository;
  CreateSubCategoryUseCase(this.subCategoryRepository);
  run(SubCategory subCategory) => subCategoryRepository.create(subCategory);
}
