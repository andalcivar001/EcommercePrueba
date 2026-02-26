import 'package:ecommerce_prueba/src/data/services/OrderPdfService.dart';
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
  OrderPdfService orderPdfService;
  OrderListBloc(this.orderUseCases, this.authUseCases, this.orderPdfService)
    : super(OrderListState()) {
    on<InitOrderListEvent>(_onInit);
    on<BusquedaOrderListEvent>(_onBusqueda);
    on<DeleteOrderListEvent>(_onDelete);
    on<GenerarPdfOrderListEvent>(_onGenerarPdf);
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

  Future<void> _onGenerarPdf(
    GenerarPdfOrderListEvent event,
    Emitter<OrderListState> emit,
  ) async {
    emit(state.copyWith(loading: true));
    final bytes = await orderPdfService.generaVenta(event.orden);
    emit(state.copyWith(pdfBytes: bytes, formKey: formKey));
  }

  Future<void> _onDelete(
    DeleteOrderListEvent event,
    Emitter<OrderListState> emit,
  ) async {}
}
