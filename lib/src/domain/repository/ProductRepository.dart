import 'dart:io';
import 'package:ecommerce_prueba/src/domain/models/Product.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';

abstract class ProductRepository {
  Future<Resource<List<Product>>> getProducts();
  Future<Resource<Product>> getProductById(String id);

  Future<Resource<Product>> create(Product product, File? file1, File? file2);

  Future<Resource<Product>> update(
    Product product,
    String id,
    File? file1,
    File? file2,
  );

  Future<Resource<bool>> delete(String id);

  Future<Resource<Product>> getProductByCodAlterno(String codAlterno);
}
