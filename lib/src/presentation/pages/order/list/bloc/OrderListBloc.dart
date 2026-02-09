import 'package:ecommerce_prueba/src/domain/models/AuthResponse.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Order/OrderUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/list/bloc/OrderListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/list/bloc/OrderListState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderListBloc extends Bloc<OrderListEvent, OrderListState> {
  OrderUseCases orderUseCases;
  AuthUseCases authUseCases;
  OrderListBloc(this.orderUseCases, this.authUseCases)
    : super(OrderListState()) {
    on<InitOrderListEvent>(_onInit);
    on<BusquedaOrderListEvent>(_onBusqueda);
    on<DeleteOrderListEvent>(_onDelete);
  }

  final formKey = GlobalKey<FormState>();

  Future<void> _onInit(
    InitOrderListEvent event,
    Emitter<OrderListState> emit,
  ) async {
    emit(state.copyWith(response: Loading(), formKey: formKey));

    AuthResponse? authResponse = await authUseCases.getUserSession.run();
    String? idUsuario;
    if (authResponse != null) {
      idUsuario = authResponse.user.id;
    }

    final response = await orderUseCases.getOrderByUser.run(idUsuario!);

    emit(state.copyWith(response: response, formKey: formKey));
  }

  Future<void> _onBusqueda(
    BusquedaOrderListEvent event,
    Emitter<OrderListState> emit,
  ) async {}

  Future<void> _onDelete(
    DeleteOrderListEvent event,
    Emitter<OrderListState> emit,
  ) async {}
}
