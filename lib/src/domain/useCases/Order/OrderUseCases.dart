import 'package:ecommerce_prueba/src/domain/useCases/Order/CreateOrderUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Order/DeleteOrderUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Order/GetOrderByIdUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Order/GetOrdersByUserUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Order/UpdateOrderUseCase.dart';

class OrderUseCases {
  GetOrdersByUserUseCase getOrderByUser;
  GetOrderByIdUseCase getOrderById;
  CreateOrderUseCase create;
  UpdateOrderUseCase update;
  DeleteOrderUseCase delete;

  OrderUseCases({
    required this.getOrderByUser,
    required this.getOrderById,
    required this.create,
    required this.update,
    required this.delete,
  });
}
