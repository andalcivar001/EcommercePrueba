import 'package:ecommerce_prueba/src/domain/useCases/Product/GetProductByIdUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Product/GetProductsUseCase.dart';

class ProductUseCases {
  GetProductUseCase getProducts;
  GetProductByIdUaseCase getBydId;
  ProductUseCases({required this.getProducts, required this.getBydId});
}
