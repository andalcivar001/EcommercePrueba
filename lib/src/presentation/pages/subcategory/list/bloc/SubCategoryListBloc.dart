import 'package:ecommerce_prueba/src/domain/models/Category.dart';
import 'package:ecommerce_prueba/src/domain/models/SubCategory.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Category/CategoryUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/SubCategory/SubCategoryUseCases.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/subcategory/list/bloc/SubCategoryListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/subcategory/list/bloc/SubCategoryListState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubCategoryListBloc
    extends Bloc<SubCategoryListEvent, SubCategoryListState> {
  CategoryUseCases categoryUseCases;
  SubCategoryUseCases subCategoryUseCases;
  SubCategoryListBloc(this.subCategoryUseCases, this.categoryUseCases)
    : super(SubCategoryListState()) {
    on<InitSubCategoryListEvent>(_onInit);
    on<BusquedaChangedSubCategoryListEvent>(_onBusquedaChanged);
    on<DeleteSubCategoryListEvent>(_onDeleted);
  }
  final formKey = GlobalKey<FormState>();

  Future<void> _onInit(
    InitSubCategoryListEvent event,
    Emitter<SubCategoryListState> emit,
  ) async {
    emit(state.copyWith(formKey: formKey));
    emit(state.copyWith(response: Loading(), formKey: formKey));
    Resource response;

    List<Category> listaCategoria = [];
    response = await categoryUseCases.getCategories.run();

    if (response is Success) {
      listaCategoria = response.data as List<Category>;
    }

    List<SubCategory> listaSubcategorias = [];
    response = await subCategoryUseCases.getSubCategories.run();

    if (response is Success) {
      listaSubcategorias = response.data as List<SubCategory>;
    }

    emit(
      state.copyWith(
        response: response,
        listaSubCategoriaResp: listaSubcategorias,
        formKey: formKey,
        listaCategoria: listaCategoria,
      ),
    );
  }

  Future<void> _onBusquedaChanged(
    BusquedaChangedSubCategoryListEvent event,
    Emitter<SubCategoryListState> emit,
  ) async {
    final filtered = state.listaSubCategoriaResp!
        .where(
          (x) =>
              x.nombre.toLowerCase().contains(event.busqueda) ||
              (x.descripcion ?? '').toLowerCase().contains(event.busqueda),
        )
        .toList();

    emit(
      state.copyWith(
        busqueda: event.busqueda,
        response: Success(filtered),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onDeleted(
    DeleteSubCategoryListEvent event,
    Emitter<SubCategoryListState> emit,
  ) async {
    emit(state.copyWith(responseDeleted: Loading(), formKey: formKey));
    final Resource response = await subCategoryUseCases.delete.run(event.id);
    emit(state.copyWith(responseDeleted: response, formKey: formKey));
  }
}
