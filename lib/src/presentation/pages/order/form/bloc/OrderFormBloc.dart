import 'package:ecommerce_prueba/src/domain/models/Client.dart';
import 'package:ecommerce_prueba/src/domain/models/Product.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Client/ClientUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Order/OrderUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Product/ProductUseCases.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/form/bloc/OrderFormEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/form/bloc/OrderFormState.dart';
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

    emit(
      state.copyWith(
        listaClientes: listaCliente,
        listaProductos: listaProduct,
        formKey: formKey,
      ),
    );
  }

  Future<void> _onClienteChanged(
    ClienteChagnedOrderFormEvent event,
    Emitter<OrderFormState> emit,
  ) async {
    emit(state.copyWith(idCliente: event.idCliente, formKey: formKey));
  }
}
