import 'package:ecommerce_prueba/src/domain/models/Product.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Product/ProductUseCases.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/utils/searchProduct/bloc/SearchProductEvent.dart';
import 'package:ecommerce_prueba/src/presentation/utils/searchProduct/bloc/SearchProductState.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchProductBloc extends Bloc<SearchProductEvent, SearchProductState> {
  ProductUseCases productUseCases;
  SearchProductBloc(this.productUseCases) : super(SearchProductState()) {
    on<InitSearchProductEvent>(_onInit);
    on<QueryChangedSearchProductEvent>(_onQueryChanged);
    on<ConsultarSearchProductEvent>(_onConsultar);
    on<ResetSearchProductEvent>(_onReset);
    on<ErrorSearchProductEvent>(_onError);
  }

  final formKey = GlobalKey<FormState>();

  Future<void> _onInit(
    InitSearchProductEvent event,
    Emitter<SearchProductState> emit,
  ) async {
    emit(state.copyWith(formKey: formKey));
  }

  Future<void> _onQueryChanged(
    QueryChangedSearchProductEvent event,
    Emitter<SearchProductState> emit,
  ) async {
    emit(state.copyWith(query: event.query, formKey: formKey));
  }

  Future<void> _onConsultar(
    ConsultarSearchProductEvent event,
    Emitter<SearchProductState> emit,
  ) async {
    if (state.query.isEmpty || state.query.trim().length < 2) {
      AppToast.warning('Ingrese por lo menos 2 caracteres para buscar');
      return;
    }

    emit(state.copyWith(response: Loading(), formKey: formKey));
    final Resource response = await productUseCases.getProductsSearch.run(
      state.query,
    );

    emit(state.copyWith(response: response, formKey: formKey));
    final List<Product> products = response is Success
        ? response.data as List<Product>
        : [];

    if (products.isEmpty && response is Success) {
      AppToast.warning('No hay productos que mostrar');
    }
  }

  Future<void> _onReset(
    ResetSearchProductEvent event,
    Emitter<SearchProductState> emit,
  ) async {
    emit(SearchProductState());
  }

  Future<void> _onError(
    ErrorSearchProductEvent event,
    Emitter<SearchProductState> emit,
  ) async {
    emit(state.copyWith(response: null, formKey: formKey));
  }
}
