import 'package:ecommerce_prueba/src/domain/repository/SubCategoryRepository.dart';

class DeleteSubCategoryUseCase {
  SubCategoryRepository subCategoryRepository;
  DeleteSubCategoryUseCase(this.subCategoryRepository);
  run(String id) => subCategoryRepository.delete(id);
}
