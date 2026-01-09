import 'package:ecommerce_prueba/src/domain/models/SubCategory.dart';
import 'package:ecommerce_prueba/src/domain/repository/SubCategoryRepository.dart';

class UpdateSubCategoryUseCase {
  SubCategoryRepository subCategoryRepository;
  UpdateSubCategoryUseCase(this.subCategoryRepository);
  run(SubCategory subCategory, String id) =>
      subCategoryRepository.update(subCategory, id);
}
