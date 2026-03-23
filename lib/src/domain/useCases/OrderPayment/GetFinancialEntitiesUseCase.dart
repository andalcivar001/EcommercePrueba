import 'package:ecommerce_prueba/src/domain/repository/OrderPaymentRepository.dart';

class GetFinancialEntitiesUseCase {
  OrderPaymentRepository orderPaymentRepository;
  GetFinancialEntitiesUseCase(this.orderPaymentRepository);
  run() => orderPaymentRepository.getFinancialEntities();
}
