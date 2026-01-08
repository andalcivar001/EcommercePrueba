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

  @override
  Future<Resource<Category>> create(Category category) async {
    return await categoryService.create(category);
  }

  @override
  Future<Resource<Category>> update(Category category, String id) async {
    return await categoryService.update(category, id);
  }
}
