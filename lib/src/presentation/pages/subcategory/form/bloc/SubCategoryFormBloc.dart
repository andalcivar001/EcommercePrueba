import 'package:ecommerce_prueba/src/domain/models/Category.dart';
import 'package:ecommerce_prueba/src/domain/models/SubCategory.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Category/CategoryUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/SubCategory/SubCategoryUseCases.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/subcategory/form/bloc/SubCategoryFormEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/subcategory/form/bloc/SubCategoryFormState.dart';
import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubCategoryFormBloc
    extends Bloc<SubCategoryFormEvent, SubCategoryFormState> {
  SubCategoryUseCases subCategoryUseCases;
  CategoryUseCases categoryUseCases;
  SubCategoryFormBloc(this.subCategoryUseCases, this.categoryUseCases)
    : super(SubCategoryFormState()) {
    on<InitSubCategoryFormEvent>(_onInit);
    on<NombreChangedSubCategoryFormEvent>(_onNombreChanged);
    on<DescripcionChangedSubCategoryFormEvent>(_onDescripcionChanged);
    on<CategoriaChangedSubCategoryFormEvent>(_onCategoriaChanged);
    on<EstadoChangedSubCategoryFormEvent>(_onEstadoChanged);
    on<SubmittedSubCategoryFormEvent>(_onSubmitted);
    on<ResetSubCategoryFormEvent>(_onReset);
  }

  final formKey = GlobalKey<FormState>();

  Future<void> _onInit(
    InitSubCategoryFormEvent event,
    Emitter<SubCategoryFormState> emit,
  ) async {
    emit(state.copyWith(responseCategory: Loading()));

    List<Category> listCategory = const [];

    final responseList = await categoryUseCases.getCategories.run();

    if (responseList is Success) {
      listCategory = responseList.data as List<Category>;
    }

    emit(
      state.copyWith(
        responseCategory: Success(true),
        id: event.subCategory?.id ?? '',
        nombre: BlocFormItem(value: event.subCategory?.nombre ?? ''),
        descripcion: BlocFormItem(value: event.subCategory?.descripcion ?? ''),
        categoria: event.subCategory?.idCategory,
        isActive: event.subCategory?.isActive ?? true,
        listCategory: listCategory,
        formKey: formKey,
      ),
    );
  }

  Future<void> _onNombreChanged(
    NombreChangedSubCategoryFormEvent event,
    Emitter<SubCategoryFormState> emit,
  ) async {
    emit(
      state.copyWith(
        nombre: BlocFormItem(
          value: event.nombre.value,
          error: event.nombre.value.isNotEmpty ? null : 'Ingrese el nombre',
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onDescripcionChanged(
    DescripcionChangedSubCategoryFormEvent event,
    Emitter<SubCategoryFormState> emit,
  ) async {
    emit(
      state.copyWith(
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

  Future<void> _onCategoriaChanged(
    CategoriaChangedSubCategoryFormEvent event,
    Emitter<SubCategoryFormState> emit,
  ) async {
    emit(state.copyWith(categoria: event.categoria, formKey: formKey));
  }

  Future<void> _onEstadoChanged(
    EstadoChangedSubCategoryFormEvent event,
    Emitter<SubCategoryFormState> emit,
  ) async {
    emit(state.copyWith(isActive: event.isActive, formKey: formKey));
  }

  Future<void> _onSubmitted(
    SubmittedSubCategoryFormEvent event,
    Emitter<SubCategoryFormState> emit,
  ) async {
    print('STATE NOMBRE ${state.nombre.value}');
    if (state.nombre.value.isEmpty) {
      AppToast.warning('ingrese el nombre');
      return;
    }

    if (state.categoria == null) {
      AppToast.warning('Debe seleccionar la categoria');
      return;
    }

    emit(state.copyWith(response: Loading(), formKey: formKey));
    final subCategory = SubCategory(
      id: state.id,
      nombre: state.nombre.value,
      descripcion: state.descripcion.value,
      idCategory: state.categoria ?? '',
      isActive: state.isActive,
    );

    if (state.id.isEmpty) {
      final Resource response = await subCategoryUseCases.create.run(
        subCategory,
      );
      emit(state.copyWith(response: response, formKey: formKey));
    } else {
      final Resource response = await subCategoryUseCases.update.run(
        subCategory,
        state.id,
      );
      emit(state.copyWith(response: response, formKey: formKey));
    }
  }

  Future<void> _onReset(
    ResetSubCategoryFormEvent event,
    Emitter<SubCategoryFormState> emit,
  ) async {
    emit(
      SubCategoryFormState(
        formKey: state.formKey,
        listCategory: state.listCategory,
      ),
    );
  }
}
