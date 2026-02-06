import 'package:ecommerce_prueba/src/domain/repository/OrderRepository.dart';

class DeleteOrderUseCase {
  OrderRepository orderRepository;
  DeleteOrderUseCase(this.orderRepository);
  run(String id) => orderRepository.delete(id);
}
