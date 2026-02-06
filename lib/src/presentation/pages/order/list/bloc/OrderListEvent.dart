import 'package:equatable/equatable.dart';

abstract class OrderListEvent extends Equatable {
  const OrderListEvent();
  @override
  List<Object?> get props => [];
}

class InitOrderListEvent extends OrderListEvent {
  const InitOrderListEvent();
}

class ClienteChangedOrderListEvent extends OrderListEvent {
  final String cliente;
  const ClienteChangedOrderListEvent({required this.cliente});
  @override
  List<Object?> get props => [cliente];
}

class FechaDesdeChangedOrderListEvent extends OrderListEvent {
  final DateTime fechaDesde;
  const FechaDesdeChangedOrderListEvent({required this.fechaDesde});
  @override
  List<Object?> get props => [fechaDesde];
}

class FechaHastaChangedOrderListEvent extends OrderListEvent {
  final DateTime fechaHasta;
  const FechaHastaChangedOrderListEvent({required this.fechaHasta});
  @override
  List<Object?> get props => [fechaHasta];
}

class ConsultarOrderListEvent extends OrderListEvent {
  const ConsultarOrderListEvent();
}
