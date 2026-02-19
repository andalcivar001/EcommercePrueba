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
    final responseProducts = results[1];

    final List<Client> listaCliente = responseClientes is Success
        ? responseClientes.data as List<Client>
        : [];

    final List<Product> listaProduct = responseProducts is Success
        ? responseProducts.data as List<Product>
        : [];

    final OrderDetail order = OrderDetail(
      idProducto: '6982b0109900501047ca13fd',
      precio: 15.10,
      cantidad: 2,
      producto: Product(
        id: '6982b0109900501047ca13fd',
        descripcion: 'Papel higiénico rollo',
        stock: 20,
        idCategory: '69610a64e581a60939693c4e',
        idSubcategory: '69685c93b81e66d5a08394fb',
        precio: 16.10,
        isActive: true,
      ),
    );
    final OrderDetail order2 = OrderDetail(
      idProducto: '6982b0daf1d96c9b389056ef',
      precio: 20.21,
      cantidad: 10,
      producto: Product(
        id: '6982b0daf1d96c9b389056ef',
        descripcion: 'Soporte De Computador',
        stock: 10,
        idCategory: '6960d65259bfdb56c6c18cdb',
        idSubcategory: '6965bcb416a62a1a0e93a639',
        precio: 20.21,
        isActive: true,
      ),
    );
    final List<OrderDetail> detalles = [];
    detalles.add(order);
    detalles.add(order2);

    emit(
      state.copyWith(
        listaClientes: listaCliente,
        listaProductos: listaProduct,
        formKey: formKey,
        orderDetail: detalles,
      ),
    );
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
    final producto = state.listaProductos.firstWhereOrNull(
      (x) => x.codAlterno == event.code,
    );
    if (producto == null) {
      AppToast.error('Codigo de producto no existe');
      return;
    }
    _agregarProducto(producto, emit);
  }

  void _agregarProducto(Product producto, Emitter<OrderFormState> emit) {
    final itemProducto = state.orderDetail.indexWhere(
      (x) => x.idProducto == producto.id,
    );

    if (itemProducto == -1) {
      final OrderDetail detalle = OrderDetail(
        idProducto: producto.id,
        precio: producto.precio ?? 0,
        cantidad: 1,
        producto: producto,
      );

      final List<OrderDetail> nuevaLista = List.from(state.orderDetail);

      nuevaLista.add(detalle);

      _calcularTotales(nuevaLista, emit);
    } else {}
  }
}
