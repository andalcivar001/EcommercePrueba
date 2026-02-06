import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:ecommerce_prueba/src/domain/repository/OrderRepository.dart';

class UpdateOrderUseCase {
  OrderRepository orderRepository;
  UpdateOrderUseCase(this.orderRepository);
  run(Order order, String id) => orderRepository.update(order, id);
}
