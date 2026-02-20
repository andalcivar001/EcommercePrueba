import 'package:ecommerce_prueba/src/domain/repository/ProductRepository.dart';

class GetProductByCodalternoUseCase {
  ProductRepository productRepository;
  GetProductByCodalternoUseCase(this.productRepository);
  run(String codAlterno) =>
      productRepository.getProductByCodAlterno(codAlterno);
}
