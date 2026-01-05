import 'package:ecommerce_prueba/src/data/datasource/remote/services/CategoryService.dart';
import 'package:ecommerce_prueba/src/domain/models/Category.dart';
import 'package:ecommerce_prueba/src/domain/repository/CategoryRepository.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  CategoryService categoryService;

  CategoryRepositoryImpl(this.categoryService);

  @override
  Future<Resource<List<Category>>> getCategories() async {
    return await categoryService.getCategories();
  }
}
