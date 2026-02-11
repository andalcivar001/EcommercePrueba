import 'package:equatable/equatable.dart';

abstract class OrderFormEvent extends Equatable {
  const OrderFormEvent();
  @override
  List<Object?> get props => [];
}

class InitOrderFormEvent extends OrderFormEvent {
  const InitOrderFormEvent();
}

class ClienteChagnedOrderFormEvent extends OrderFormEvent {
  final String idCliente;
  const ClienteChagnedOrderFormEvent({required this.idCliente});
  @override
  List<Object?> get props => [idCliente];
}

class SubmittedOrderFormEvent extends OrderFormEvent {
  const SubmittedOrderFormEvent();
}
