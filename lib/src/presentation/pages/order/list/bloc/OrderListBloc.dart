import 'package:ecommerce_prueba/src/data/services/PdfOrderService.dart';
import 'package:ecommerce_prueba/src/domain/models/AuthResponse.dart';
import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Order/OrderUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/list/bloc/OrderListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/list/bloc/OrderListState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class OrderListBloc extends Bloc<OrderListEvent, OrderListState> {
  OrderUseCases orderUseCases;
  AuthUseCases authUseCases;
  PdfOrderService pdfOrderService;
  OrderListBloc(this.orderUseCases, this.authUseCases, this.pdfOrderService)
    : super(OrderListState()) {
    on<InitOrderListEvent>(_onInit);
    on<BusquedaOrderListEvent>(_onBusqueda);
    on<DeleteOrderListEvent>(_onDelete);
    on<GenerarPdfOrderListEvent>(_onGenerarPdf);
    on<CompartirPdfOrderListEvent>(_onCompartirPdf);
    on<ClearPdfOrderListEvent>(_onClearPdf);
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
    emit(state.copyWith(loading: true, formKey: formKey));
    final bytes = await pdfOrderService.generaVenta(event.orden);
    final pdfNombre = _obtienePdfName(event.orden);
    emit(
      state.copyWith(
        pdfBytes: bytes,
        loading: false,
        accion: 'IMPRIMIR',
        pdfNombre: pdfNombre,
        formKey: formKey,
      ),
    );
  }

  Future<void> _onCompartirPdf(
    CompartirPdfOrderListEvent event,
    Emitter<OrderListState> emit,
  ) async {
    emit(state.copyWith(loading: true, formKey: formKey));
    final bytes = await pdfOrderService.generaVenta(event.orden);
    final pdfNombre = _obtienePdfName(event.orden);
    emit(
      state.copyWith(
        pdfBytes: bytes,
        loading: false,
        accion: 'COMPARTIR',
        pdfNombre: pdfNombre,
        formKey: formKey,
      ),
    );
  }

  String _obtienePdfName(Order orden) {
    String nombre = '';
    String fecha = DateFormat('yyyy-MM-dd').format(orden.fecha);
    nombre = 'Venta_${orden.secuencia.toString()}_$fecha.pdf';
    return nombre;
  }

  Future<void> _onClearPdf(
    ClearPdfOrderListEvent event,
    Emitter<OrderListState> emit,
  ) async {
    emit(state.copyWith(pdfBytes: null, accion: '', formKey: formKey));
  }

  Future<void> _onDelete(
    DeleteOrderListEvent event,
    Emitter<OrderListState> emit,
  ) async {
    emit(state.copyWith(loading: true, formKey: formKey));
    final response = await orderUseCases.delete.run(event.id);
    emit(
      state.copyWith(
        responseDelete: response,
        loading: false,
        formKey: formKey,
      ),
    );
  }
}
