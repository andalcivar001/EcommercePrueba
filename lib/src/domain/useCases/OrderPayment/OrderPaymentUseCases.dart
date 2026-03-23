import 'package:ecommerce_prueba/src/domain/useCases/OrderPayment/CreateOrderPaymentUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/OrderPayment/DeleteOrderPaymentUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/OrderPayment/GetFinancialEntitiesUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/OrderPayment/GetOrderPaymentByIdUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/OrderPayment/GetOrderPaymentsByOrdenUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/OrderPayment/GetPaymentMethodsUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/OrderPayment/UpdateOrderPaymentUseCase.dart';

class OrderPaymentUseCases {
  GetOrderPaymentByIdUseCase getOrderPaymentByIdUseCase;
  GetOrderPaymentsByOrdenUseCase getOrderPaymentsByOrdenUseCase;
  CreateOrderPaymentUseCase createOrderPaymentUseCase;
  UpdateOrderPaymentUseCase updateOrderPaymentUseCase;
  DeleteOrderPaymentUseCase deleteOrderPaymentUseCase;
  GetPaymentMethodsUseCase getPaymentMethodsUseCase;
  GetFinancialEntitiesUseCase getFinancialEntitiesUseCase;
  OrderPaymentUseCases({
    required this.getOrderPaymentByIdUseCase,
    required this.getOrderPaymentsByOrdenUseCase,
    required this.createOrderPaymentUseCase,
    required this.updateOrderPaymentUseCase,
    required this.deleteOrderPaymentUseCase,
    required this.getPaymentMethodsUseCase,
    required this.getFinancialEntitiesUseCase,
  });
}
