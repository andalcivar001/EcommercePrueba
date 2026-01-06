import 'package:ecommerce_prueba/src/domain/models/Category.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Category/CategoryUseCases.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/category/list/bloc/CategoryListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/category/list/bloc/CategoryListState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryListBloc extends Bloc<CategoryListEvent, CategoryListState> {
  CategoryUseCases categoryUseCases;

  CategoryListBloc(this.categoryUseCases) : super(CategoryListState()) {
    on<InitCategoryListEvent>(_onInit);
    on<BusquedaChangedListEvent>(_onBusquedaChanged);
  }

  final formKey = GlobalKey<FormState>();

  Future<void> _onInit(
    InitCategoryListEvent event,
    Emitter<CategoryListState> emit,
  ) async {
    emit(state.copyWith(formKey: formKey));
    final Resource response = await categoryUseCases.getCategories.run();
    if (response is Success) {
      emit(state.copyWith(response: Loading(), formKey: formKey));

      emit(state.copyWith(response: response, formKey: formKey));
    }
  }

  Future<void> _onBusquedaChanged(
    BusquedaChangedListEvent event,
    Emitter<CategoryListState> emit,
  ) async {
    emit(state.copyWith(busqueda: event.busqueda, formKey: formKey));
  }
}
