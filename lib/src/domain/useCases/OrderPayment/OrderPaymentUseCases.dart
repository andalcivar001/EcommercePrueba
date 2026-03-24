import 'package:ecommerce_prueba/src/domain/useCases/OrderPayment/CreateOrderPaymentUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/OrderPayment/DeleteOrderPaymentUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/OrderPayment/GetFinancialEntitiesUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/OrderPayment/GetOrderPaymentByIdUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/OrderPayment/GetOrderPaymentsByOrdenUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/OrderPayment/GetPaymentMethodsUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/OrderPayment/UpdateOrderPaymentUseCase.dart';

class OrderPaymentUseCases {
  GetOrderPaymentByIdUseCase getOrderPaymentById;
  GetOrderPaymentsByOrdenUseCase getOrderPaymentsByOrden;
  CreateOrderPaymentUseCase createOrderPayment;
  UpdateOrderPaymentUseCase updateOrderPayment;
  DeleteOrderPaymentUseCase deleteOrderPayment;
  GetPaymentMethodsUseCase getPaymentMethods;
  GetFinancialEntitiesUseCase getFinancialEntities;
  OrderPaymentUseCases({
    required this.getOrderPaymentById,
    required this.getOrderPaymentsByOrden,
    required this.createOrderPayment,
    required this.updateOrderPayment,
    required this.deleteOrderPayment,
    required this.getPaymentMethods,
    required this.getFinancialEntities,
  });
}
