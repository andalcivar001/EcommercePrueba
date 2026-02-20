import 'package:ecommerce_prueba/src/domain/useCases/Product/CreateProductUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Product/DeleteProductUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Product/GetProductByCodAlternoUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Product/GetProductByIdUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Product/GetProductsUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Product/UpdateProductUseCase.dart';

class ProductUseCases {
  GetProductUseCase getProducts;
  GetProductByIdUaseCase getBydId;
  CreateProductUseCase create;
  UpdateProductUseCase update;
  DeleteProductUseCase delete;
  GetProductByCodalternoUseCase getByCodAlterno;
  ProductUseCases({
    required this.getProducts,
    required this.getBydId,
    required this.create,
    required this.update,
    required this.delete,
    required this.getByCodAlterno,
  });
}
