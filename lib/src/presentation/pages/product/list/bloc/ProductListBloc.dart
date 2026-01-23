import 'package:ecommerce_prueba/src/domain/models/Product.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Product/ProductUseCases.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/product/list/bloc/ProductListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/product/list/bloc/ProductListState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductUseCases productUseCases;
  ProductListBloc(this.productUseCases) : super(ProductListState()) {
    on<InitProductListEvent>(_onInit);
    on<BusquedaChangedProductListEvent>(_onBusquedaChanged);
    on<DeleteProductListEvent>(_onDelete);
  }

  final formKey = GlobalKey<FormState>();

  Future<void> _onInit(
    InitProductListEvent event,
    Emitter<ProductListState> emit,
  ) async {
    emit(state.copyWith(formKey: formKey));

    emit(state.copyWith(response: Loading(), formKey: formKey));

    final Resource response = await productUseCases.getProducts.run();
    List<Product> listaProduct = [];
    if (response is Success) {
      listaProduct = response.data as List<Product>;
    }
    emit(
      state.copyWith(
        response: response,
        listaProduct: listaProduct,
        formKey: formKey,
      ),
    );
  }

  Future<void> _onBusquedaChanged(
    BusquedaChangedProductListEvent event,
    Emitter<ProductListState> emit,
  ) async {
    final filtrado = state.listaProduct!
        .where(
          (x) => x.descripcion.toLowerCase().contains(
            event.busqueda.toLowerCase(),
          ),
        )
        .toList();

    emit(
      state.copyWith(
        busqueda: event.busqueda,
        formKey: formKey,
        response: Success(filtrado),
      ),
    );
  }

  Future<void> _onDelete(
    DeleteProductListEvent event,
    Emitter<ProductListState> emit,
  ) async {
    emit(state.copyWith(responseDelete: Loading(), formKey: formKey));

    final Resource response = await productUseCases.delete.run(event.id);

    emit(state.copyWith(responseDelete: response, formKey: formKey));
  }
}
