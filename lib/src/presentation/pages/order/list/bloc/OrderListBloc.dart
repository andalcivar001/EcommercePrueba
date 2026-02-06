import 'package:ecommerce_prueba/src/domain/useCases/Client/ClientUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Order/OrderUseCases.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/list/bloc/OrderListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/list/bloc/OrderListState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderListBloc extends Bloc<OrderListEvent, OrderListState> {
  OrderUseCases orderUseCases;
  ClientUseCases clientUseCases;
  OrderListBloc(this.orderUseCases, this.clientUseCases)
    : super(OrderListState()) {
    on<InitOrderListEvent>(_onInit);
    on<ClienteChangedOrderListEvent>(_onClienteChanged);
    on<FechaDesdeChangedOrderListEvent>(_onFechaDesdeChanged);
    on<FechaHastaChangedOrderListEvent>(_onFechaHastaChanged);
    on<ConsultarOrderListEvent>(_onConsultar);
  }

  final formKey = GlobalKey<FormState>();

  Future<void> _onInit(
    InitOrderListEvent event,
    Emitter<OrderListState> emit,
  ) async {
    emit(state.copyWith(responseCliente: Loading()));
    final responseClientes = await clientUseCases.getClients.run();

    emit(
      state.copyWith(
        responseCliente: responseClientes,
        fechaDesde: DateTime.now(),
        fechaHasta: DateTime.now(),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onClienteChanged(
    ClienteChangedOrderListEvent event,
    Emitter<OrderListState> emit,
  ) async {
    emit(state.copyWith(cliente: event.cliente, formKey: formKey));
  }

  Future<void> _onFechaDesdeChanged(
    FechaDesdeChangedOrderListEvent event,
    Emitter<OrderListState> emit,
  ) async {
    emit(state.copyWith(fechaDesde: event.fechaDesde, formKey: formKey));
  }

  Future<void> _onFechaHastaChanged(
    FechaHastaChangedOrderListEvent event,
    Emitter<OrderListState> emit,
  ) async {
    emit(state.copyWith(fechaHasta: event.fechaHasta, formKey: formKey));
  }

  Future<void> _onConsultar(
    ConsultarOrderListEvent event,
    Emitter<OrderListState> emit,
  ) async {
    emit(state.copyWith(response: Loading(), formKey: formKey));
    final String? idCliente = state.clienteSeleccionado != null
        ? state.clienteSeleccionado?.id
        : '';
    final response = await orderUseCases.consultar.run(
      idCliente ?? '',
      state.fechaDesde!,
      state.fechaHasta!,
    );

    emit(state.copyWith(response: response, formKey: formKey));
  }
}
