import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CategoryListState extends Equatable {
  final String? busqueda;
  final Resource? response;
  final GlobalKey<FormState>? formKey;
  const CategoryListState({this.busqueda, this.response, this.formKey});

  CategoryListState copyWith({
    String? busqueda,
    Resource? response,
    GlobalKey<FormState>? formKey,
  }) {
    return CategoryListState(
      busqueda: busqueda ?? this.busqueda,
      response: response ?? this.response,
      formKey: formKey,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [busqueda, response];
}
