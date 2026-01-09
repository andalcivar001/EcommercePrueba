import 'package:ecommerce_prueba/src/data/datasource/remote/services/SubCategoryService.dart';
import 'package:ecommerce_prueba/src/domain/models/SubCategory.dart';
import 'package:ecommerce_prueba/src/domain/repository/SubCategoryRepository.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';

class SubCategoryRepositoryImpl extends SubCategoryRepository {
  SubCategoryService subCategoryService;

  SubCategoryRepositoryImpl(this.subCategoryService);

  @override
  Future<Resource<List<SubCategory>>> getSubCategories() async {
    return await subCategoryService.getSubCategories();
  }

  @override
  Future<Resource<SubCategory>> create(SubCategory subCategory) async {
    return await subCategoryService.create(subCategory);
  }

  @override
  Future<Resource<SubCategory>> update(
    SubCategory subCategory,
    String id,
  ) async {
    return await subCategoryService.update(subCategory, id);
  }

  @override
  Future<Resource<bool>> delete(String id) async {
    return await subCategoryService.delete(id);
  }
}
