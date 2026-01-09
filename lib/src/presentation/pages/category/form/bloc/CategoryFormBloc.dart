import 'package:ecommerce_prueba/src/domain/models/Category.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Category/CategoryUseCases.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/category/form/bloc/CategoryFormEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/category/form/bloc/CategoryFormState.dart';
import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryFormBloc extends Bloc<CategoryFormEvent, CategoryFormState> {
  CategoryUseCases categoryUseCases;

  CategoryFormBloc(this.categoryUseCases) : super(CategoryFormState()) {
    on<InitCategoryFormEvent>(_onInit);
    on<NombreChangedCategoryFormEvent>(_onNombreChanged);
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
        nombre: BlocFormItem(value: event.category?.nombre ?? ''),
        descripcion: BlocFormItem(value: event.category?.descripcion ?? ''),
        isActive: event.category?.isActive ?? false,
        formKey: formKey,
      ),
    );
  }

  Future<void> _onNombreChanged(
    NombreChangedCategoryFormEvent event,
    Emitter<CategoryFormState> emit,
  ) async {
    emit(
      state.coypWith(
        nombre: BlocFormItem(
          value: event.nombre.value,
          error: event.nombre.value.isNotEmpty ? null : 'Ingrese el nombre',
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onDescripcionChanged(
    DescripcionChangedCategoryFormEvent event,
    Emitter<CategoryFormState> emit,
  ) async {
    emit(
      state.coypWith(
        descripcion: BlocFormItem(
          value: event.descripcion.value,
          error: event.descripcion.value.isNotEmpty
              ? null
              : 'Ingrese la descripcion',
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onFormSubmitted(
    FormSubmittedCategoryFormEvent event,
    Emitter<CategoryFormState> emit,
  ) async {
    emit(state.coypWith(response: Loading(), formKey: formKey));

    final category = Category(
      id: state.id,
      nombre: state.nombre.value,
      descripcion: state.descripcion.value,
      isActive: state.isActive,
    );

    if (state.id.isNotEmpty) {
      Resource response = await categoryUseCases.update.run(category, state.id);
      emit(state.coypWith(response: response, formKey: formKey));
    } else {
      Resource response = await categoryUseCases.create.run(category);
      emit(state.coypWith(response: response, formKey: formKey));
    }
  }
}
