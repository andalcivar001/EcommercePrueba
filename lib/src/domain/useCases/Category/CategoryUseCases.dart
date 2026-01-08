import 'package:ecommerce_prueba/src/domain/useCases/Category/CreateCategoryUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Category/GetCategoriesUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Category/UpdateCategoryUseCase.dart';

class CategoryUseCases {
  GetCategoriesUseCase getCategories;
  CreateCategoryUseCase create;
  UpdateCategoryUseCase update;
  CategoryUseCases({
    required this.getCategories,
    required this.create,
    required this.update,
  });
}
