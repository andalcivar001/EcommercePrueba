import 'dart:io';

import 'package:ecommerce_prueba/src/data/datasource/remote/services/ProductService.dart';
import 'package:ecommerce_prueba/src/domain/models/Product.dart';
import 'package:ecommerce_prueba/src/domain/repository/ProductRepository.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';

class ProductRepositoryImpl extends ProductRepository {
  ProductService productService;

  ProductRepositoryImpl(this.productService);

  @override
  Future<Resource<Product>> create(
    Product product,
    File? file1,
    File? file2,
  ) async {
    return await productService.create(product, file1, file2);
  }

  @override
  Future<Resource<bool>> delete(String id) async {
    return await productService.delete(id);
  }

  @override
  Future<Resource<Product>> getProductById(String id) async {
    return await productService.getProductById(id);
  }

  @override
  Future<Resource<List<Product>>> getProducts() async {
    return await productService.getProducts();
  }

  @override
  Future<Resource<Product>> update(
    Product product,
    String id,
    File? file1,
    File? file2,
  ) async {
    return await productService.update(product, id, file1, file2);
  }

  @override
  Future<Resource<Product>> getProductByCodAlterno(String codAlterno) async {
    return await productService.getProductByCodAlterno(codAlterno);
  }
}
