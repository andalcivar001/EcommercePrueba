import 'dart:io';

import 'package:ecommerce_prueba/src/domain/models/Product.dart';
import 'package:ecommerce_prueba/src/domain/repository/ProductRepository.dart';

class CreateProductUseCase{
  ProductRepository productRepository;

  CreateProductUseCase(this.productRepository);

  run(Product product, File? file1, File? file2) => productRepository.create(product, file1, file2);
}