import 'package:ecommerce_prueba/src/domain/models/SubCategory.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class SubCategoryListState extends Equatable {
  final Resource? response;
  final Resource? responseDelete;
  final String? busqueda;
  final GlobalKey<FormState>? formKey;
  final List<SubCategory>? listaSubCategoriaResp;

  const SubCategoryListState({
    this.response,
    this.responseDelete,
    this.busqueda,
    this.formKey,
    this.listaSubCategoriaResp,
  });

  SubCategoryListState copyWith({
    Resource? response,
    Resource? responseDeleted,
    String? busqueda,
    GlobalKey<FormState>? formKey,
    List<SubCategory>? listaSubCategoriaResp,
  }) {
    return SubCategoryListState(
      response: response,
      responseDelete: responseDeleted,
      busqueda: busqueda ?? this.busqueda,
      formKey: formKey,
      listaSubCategoriaResp:
          listaSubCategoriaResp ?? this.listaSubCategoriaResp,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    response,
    responseDelete,
    busqueda,
    listaSubCategoriaResp,
  ];
}
