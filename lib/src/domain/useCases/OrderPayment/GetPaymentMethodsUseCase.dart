import 'package:ecommerce_prueba/src/domain/repository/OrderPaymentRepository.dart';

class GetPaymentMethodsUseCase {
  OrderPaymentRepository orderPaymentRepository;
  GetPaymentMethodsUseCase(this.orderPaymentRepository);
  run() => orderPaymentRepository.getPaymentMethods();
}
