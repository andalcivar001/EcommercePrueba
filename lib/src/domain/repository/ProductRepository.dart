import 'package:ecommerce_prueba/src/domain/models/Category.dart';
import 'package:ecommerce_prueba/src/domain/models/Product.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';

abstract class ProductRepository {
  Future<Resource<List<Product>>> getProducts();
  Future<Resource<Product>> getProductById(String id);

  Future<Resource<Product>> create(Product product);

  Future<Resource<Product>> update(Product product, String id);

  Future<Resource<bool>> delete(String id);
}
