import 'package:ecommerce_prueba/src/domain/repository/OrderRepository.dart';

class GetOrdersByUserUseCase {
  OrderRepository orderRepository;
  GetOrdersByUserUseCase(this.orderRepository);
  run(String idUsuario) => orderRepository.getOrderByUser(idUsuario);
}
