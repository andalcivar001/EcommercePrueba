import 'dart:io';

import 'package:ecommerce_prueba/src/domain/models/Product.dart';
import 'package:ecommerce_prueba/src/domain/repository/ProductRepository.dart';

class UpdateProductUseCase{
  ProductRepository productRepository;

  UpdateProductUseCase(this.productRepository);

  run(Product product, String id, File? file1, File? file2) => productRepository.update(product,id, file1, file2);
}