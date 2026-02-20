import 'package:collection/collection.dart';
import 'package:ecommerce_prueba/src/domain/models/Client.dart';
import 'package:ecommerce_prueba/src/domain/models/OrderDetail.dart';
import 'package:ecommerce_prueba/src/domain/models/Product.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Client/ClientUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Order/OrderUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Product/ProductUseCases.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/form/bloc/OrderFormEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/form/bloc/OrderFormState.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/vibration.dart';

class OrderFormBloc extends Bloc<OrderFormEvent, OrderFormState> {
  OrderUseCases orderUseCases;
  ClientUseCases clientUseCases;
  ProductUseCases productUseCases;

  OrderFormBloc(this.orderUseCases, this.clientUseCases, this.productUseCases)
    : super(OrderFormState()) {
    on<InitOrderFormEvent>(_onInit);
    on<ClienteChagnedOrderFormEvent>(_onClienteChanged);
    on<AumentarCantidadOrderFormEvent>(_onAumentarCantidad);
    on<RestarCantidadOrderFormEvent>(_onRestarCantidad);
    on<BuscarQrProductFormEvent>(_onBuscarQr);
  }

  final formKey = GlobalKey<FormState>();

  Future<void> _onInit(
    InitOrderFormEvent event,
    Emitter<OrderFormState> emit,
  ) async {
    emit(state.copyWith(loading: true, formKey: formKey));

    final results = await Future.wait<Resource>([
      clientUseCases.getClients.run(),
      productUseCases.getProducts.run(),
    ]);

    emit(state.copyWith(loading: false, formKey: formKey));

    final responseClientes = results[0];

    final List<Client> listaCliente = responseClientes is Success
        ? responseClientes.data as List<Client>
        : [];

    emit(state.copyWith(listaClientes: listaCliente, formKey: formKey));

    // final hasVibrator = await Vibration.hasVibrator();
    // print("hasVibrator: $hasVibrator");

    // if (hasVibrator) {
    //   Vibration.vibrate(duration: 500);
    // }
  }

  Future<void> _onClienteChanged(
    ClienteChagnedOrderFormEvent event,
    Emitter<OrderFormState> emit,
  ) async {
    emit(state.copyWith(idCliente: event.idCliente, formKey: formKey));
  }

  Future<void> _onAumentarCantidad(
    AumentarCantidadOrderFormEvent event,
    Emitter<OrderFormState> emit,
  ) async {
    final List<OrderDetail> nuevaLista = List.from(state.orderDetail);

    final index = nuevaLista.indexWhere(
      (x) => x.idProducto == event.orderDetail.idProducto,
    );

    if (index != -1) {
      final itemActual = nuevaLista[index];
      itemActual.cantidad = itemActual.cantidad + 1;
      nuevaLista[index] = itemActual;

      _calcularTotales(nuevaLista, emit);
    }
  }

  Future<void> _onRestarCantidad(
    RestarCantidadOrderFormEvent event,
    Emitter<OrderFormState> emit,
  ) async {
    final List<OrderDetail> nuevaLista = List.from(state.orderDetail);

    final index = nuevaLista.indexWhere(
      (x) => x.idProducto == event.orderDetail.idProducto,
    );

    if (index != -1) {
      OrderDetail itemActual = nuevaLista[index];

      if (itemActual.cantidad > 1) {
        itemActual.cantidad = itemActual.cantidad - 1;
        nuevaLista[index] = itemActual;
      } else {
        nuevaLista.removeAt(index);
      }

      _calcularTotales(nuevaLista, emit);
    }
  }

  void _calcularTotales(List<OrderDetail> lista, Emitter<OrderFormState> emit) {
    double subtotal = 0;

    for (var x in lista) {
      subtotal = subtotal + (x.cantidad * x.precio);
    }

    final impuestos = subtotal * 0.12;
    final total = subtotal + impuestos;

    emit(
      state.copyWith(
        orderDetail: lista,
        subtotal: subtotal,
        impuestos: impuestos,
        total: total,
        formKey: formKey,
      ),
    );
  }

  Future<void> _onBuscarQr(
    BuscarQrProductFormEvent event,
    Emitter<OrderFormState> emit,
  ) async {
    emit(state.copyWith(loading: true, formKey: formKey));

    final response = await productUseCases.getByCodAlterno.run(
      event.codAlterno,
    );

    emit(state.copyWith(loading: false, formKey: formKey));

    final Product? producto = response is Success
        ? response.data as Product
        : null;

    if (producto == null) {
      AppToast.error('Codigo de producto no existe');
      return;
    }
    _agregarProducto(producto, emit);
  }

  void _agregarProducto(Product producto, Emitter<OrderFormState> emit) {
    final List<OrderDetail> nuevaLista = List.from(state.orderDetail);

    final index = nuevaLista.indexWhere((x) => x.idProducto == producto.id);

    if (index == -1) {
      final OrderDetail detalle = OrderDetail(
        idProducto: producto.id,
        precio: producto.precio ?? 0,
        cantidad: 1,
        producto: producto,
      );

      nuevaLista.add(detalle);
    } else {
      nuevaLista[index].cantidad = nuevaLista[index].cantidad + 1;
    }
    _calcularTotales(nuevaLista, emit);
  }
}
