import 'package:ecommerce_prueba/src/data/datasource/remote/services/OrderService.dart';
import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:ecommerce_prueba/src/domain/repository/OrderRepository.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';

class OrderRepositoryImpl extends OrderRepository {
  OrderService orderService;

  OrderRepositoryImpl(this.orderService);

  @override
  Future<Resource<Order>> getOrderById(String id) async {
    return await orderService.getOrderById(id);
  }

  @override
  Future<Resource<Order>> create(Order order) async {
    return await orderService.create(order);
  }

  @override
  Future<Resource<Order>> update(Order order, String id) async {
    return await orderService.update(order, id);
  }

  @override
  Future<Resource<bool>> delete(String id) async {
    return await orderService.delete(id);
  }

  @override
  Future<Resource<List<Order>>> consultar(
    String idCliente,
    DateTime fechaDesde,
    DateTime fechaHasta,
  ) async {
    return await orderService.consultar(idCliente, fechaDesde, fechaHasta);
  }
}
