import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:equatable/equatable.dart';

abstract class OrderListEvent extends Equatable {
  const OrderListEvent();
  @override
  List<Object?> get props => [];
}

class InitOrderListEvent extends OrderListEvent {
  const InitOrderListEvent();
}

class BusquedaOrderListEvent extends OrderListEvent {
  final String busqueda;
  const BusquedaOrderListEvent({required this.busqueda});
  @override
  List<Object?> get props => [busqueda];
}

class DeleteOrderListEvent extends OrderListEvent {
  const DeleteOrderListEvent();
}
