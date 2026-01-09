import 'package:ecommerce_prueba/src/domain/models/SubCategory.dart';
import 'package:ecommerce_prueba/src/domain/useCases/SubCategory/SubCategoryUseCases.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/subcategory/list/bloc/SubCategoryListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/subcategory/list/bloc/SubCategoryListState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubCategoryListBloc
    extends Bloc<SubCategoryListEvent, SubCategoryListState> {
  SubCategoryUseCases subCategoryUseCases;
  SubCategoryListBloc(this.subCategoryUseCases)
    : super(SubCategoryListState()) {
    on<InitSubCategoryListEvent>(_onInit);
    on<BusquedaChangedSubCategoryListEvent>(_onBusquedaChanged);
    on<DeletedSubCategoryListEvent>(_onDeleted);
  }
  final formKey = GlobalKey<FormState>();

  Future<void> _onInit(
    InitSubCategoryListEvent event,
    Emitter<SubCategoryListState> emit,
  ) async {
    emit(state.copyWith(formKey: formKey));
    emit(state.copyWith(response: Loading(), formKey: formKey));
    final Resource response = await subCategoryUseCases.getSubCategories.run();
    List<SubCategory> listaSubcategorias = [];

    if (response is Success) {
      listaSubcategorias = response.data as List<SubCategory>;
    }

    emit(
      state.copyWith(
        response: response,
        listaSubCategoriaResp: listaSubcategorias,
        formKey: formKey,
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
    DeletedSubCategoryListEvent event,
    Emitter<SubCategoryListState> emit,
  ) async {}
}
