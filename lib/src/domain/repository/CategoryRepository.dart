import 'package:ecommerce_prueba/src/domain/models/Category.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';

abstract class CategoryRepository {
  Future<Resource<List<Category>>> getCategories();
}
