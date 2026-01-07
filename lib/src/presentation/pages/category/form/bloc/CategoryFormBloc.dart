import 'package:ecommerce_prueba/src/presentation/pages/category/form/bloc/CategoryFormEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/category/form/bloc/CategoryFormState.dart';
import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryFormBloc extends Bloc<CategoryFormEvent, CategoryFormState> {
  CategoryFormBloc() : super(CategoryFormState()) {
    on<InitCategoryFormEvent>(_onInit);
    on<DescripcionChangedCategoryFormEvent>(_onDescripcionChanged);
    on<FormSubmittedCategoryFormEvent>(_onFormSubmitted);
  }
  final formKey = GlobalKey<FormState>();

  Future<void> _onInit(
    InitCategoryFormEvent event,
    Emitter<CategoryFormState> emit,
  ) async {
    emit(
      state.coypWith(
        id: event.category?.id ?? '',
        descripcion: BlocFormItem(value: event.category?.descripcion ?? ''),
        isActive: event.category?.isActive ?? false,
        formKey: formKey,
      ),
    );
  }

  Future<void> _onDescripcionChanged(
    DescripcionChangedCategoryFormEvent event,
    Emitter<CategoryFormState> emit,
  ) async {}

  Future<void> _onFormSubmitted(
    FormSubmittedCategoryFormEvent event,
    Emitter<CategoryFormState> emit,
  ) async {}
}
