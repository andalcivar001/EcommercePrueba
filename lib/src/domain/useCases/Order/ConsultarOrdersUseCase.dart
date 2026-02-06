import 'package:ecommerce_prueba/src/domain/repository/OrderRepository.dart';

class ConsultarOrdersUseCase {
  OrderRepository orderRepository;
  ConsultarOrdersUseCase(this.orderRepository);
  run(String idCliente, DateTime fechaDesde, DateTime fechaHasta) =>
      orderRepository.consultar(idCliente, fechaDesde, fechaHasta);
}
