import 'package:ecommerce_prueba/src/domain/models/SubCategory.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';

abstract class SubCategoryRepository {
  Future<Resource<List<SubCategory>>> getSubCategories();
  Future<Resource<SubCategory>> create(SubCategory subCategory);
  Future<Resource<SubCategory>> update(SubCategory subCategory, String id);
  Future<Resource<bool>> delete(String id);
}
