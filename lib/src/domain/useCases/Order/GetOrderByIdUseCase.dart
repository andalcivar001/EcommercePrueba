import 'package:ecommerce_prueba/src/domain/repository/OrderRepository.dart';

class GetOrderByIdUseCase {
  OrderRepository orderRepository;
  GetOrderByIdUseCase(this.orderRepository);
  run(String id) => orderRepository.getOrderById(id);
}
