import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';

abstract class OrderRepository {
  Future<Resource<Order>> getOrderById(String id);
  Future<Resource<Order>> create(Order order);
  Future<Resource<Order>> update(Order order, String id);
  Future<Resource<bool>> delete(String id);
  Future<Resource<List<Order>>> getOrderByUser(String idUsuario);
}
