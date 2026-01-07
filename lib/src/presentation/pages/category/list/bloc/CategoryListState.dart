import 'package:ecommerce_prueba/src/domain/models/Category.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CategoryListState extends Equatable {
  final String? busqueda;
  final Resource? response;
  final List<Category>? listaCategoryResp;
  final GlobalKey<FormState>? formKey;
  const CategoryListState({
    this.busqueda,
    this.response,
    this.formKey,
    this.listaCategoryResp,
  });

  CategoryListState copyWith({
    String? busqueda,
    Resource? response,
    GlobalKey<FormState>? formKey,
    List<Category>? listaCategoryResp,
  }) {
    return CategoryListState(
      busqueda: busqueda ?? this.busqueda,
      listaCategoryResp: listaCategoryResp ?? this.listaCategoryResp,
      response: response,
      formKey: formKey,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [busqueda, response, listaCategoryResp];
}
