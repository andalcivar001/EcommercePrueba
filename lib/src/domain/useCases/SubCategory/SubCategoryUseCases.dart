import 'package:ecommerce_prueba/src/domain/useCases/SubCategory/CreateSubCategoryUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/SubCategory/DeleteSubCategoryUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/SubCategory/GetSubCategoriesUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/SubCategory/UpdateSubCategoryUseCase.dart';

class SubCategoryUseCases {
  GetSubCategoriesUseCase getSubCategories;
  CreateSubCategoryUseCase create;
  UpdateSubCategoryUseCase update;
  DeleteSubCategoryUseCase delete;

  SubCategoryUseCases({
    required this.getSubCategories,
    required this.create,
    required this.update,
    required this.delete,
  });
}
