import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:ecommerce_prueba/src/domain/repository/OrderRepository.dart';

class CreateOrderUseCase {
  OrderRepository orderRepository;
  CreateOrderUseCase(this.orderRepository);
  run(Order order) => orderRepository.create(order);
}
