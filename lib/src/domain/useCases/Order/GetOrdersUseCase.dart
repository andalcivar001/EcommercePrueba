import 'package:ecommerce_prueba/src/domain/repository/OrderRepository.dart';

class GetOrdersUseCase{
  OrderRepository orderRepository;
  GetOrdersUseCase(this.orderRepository);
  run()=>orderRepository.getOrders();
}