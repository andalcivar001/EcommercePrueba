import 'package:ecommerce_prueba/src/domain/useCases/Order/CreateOrderUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Order/DeleteOrderUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Order/GetOrderByIdUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Order/GetOrdersUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Order/UpdateOrderUseCase.dart';

class OrderUseCases {
  GetOrdersUseCase getOrders;
  GetOrderByIdUseCase getOrderById;
  CreateOrderUseCase create;
  UpdateOrderUseCase update;
  DeleteOrderUseCase delete;

  OrderUseCases({
    required this.getOrders,
    required this.getOrderById,
    required this.create,
    required this.update,
    required this.delete,
  });
}
