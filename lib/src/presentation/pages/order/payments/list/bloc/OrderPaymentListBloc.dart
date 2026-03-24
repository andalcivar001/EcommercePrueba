import 'package:ecommerce_prueba/src/domain/useCases/Order/OrderUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/OrderPayment/OrderPaymentUseCases.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/payments/list/bloc/OrderPaymentListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/payments/list/bloc/OrderPaymentListState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPaymentListBloc
    extends Bloc<OrderPaymentListEvent, OrderPaymentListState> {
  OrderUseCases orderUseCases;
  OrderPaymentUseCases orderPaymentUseCases;
  OrderPaymentListBloc(this.orderUseCases, this.orderPaymentUseCases)
    : super(OrderPaymentListState()) {
    on<InitOrderPaymentListEvent>(_onInit);
  }
  final formKey = GlobalKey<FormState>();

  Future<void> _onInit(
    InitOrderPaymentListEvent event,
    Emitter<OrderPaymentListState> emit,
  ) async {
    emit(state.copyWith(loading: true, formKey: formKey));

    final results = await Future.wait<Resource>([
      orderUseCases.getOrderById.run(event.idOrden),
      orderPaymentUseCases.getOrderPaymentsByOrden.run(event.idOrden),
    ]);

    emit(
      state.copyWith(
        loading: false,
        responseOrden: results[0],
        responsePagos: results[1],
        formKey: formKey,
      ),
    );
  }
}
