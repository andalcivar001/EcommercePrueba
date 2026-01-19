import 'package:ecommerce_prueba/src/domain/models/Product.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ProductListState extends Equatable {
  final String busqueda;
  final Resource? response;
  final Resource? responseDelete;
  final List<Product>? listaProduct;
  final GlobalKey<FormState>? formKey;

  ProductListState({
    this.busqueda = '',
    this.responseDelete,
    this.response,
    this.formKey,
    this.listaProduct,
  });

  ProductListState copyWith({
    String? busqueda,
    Resource? response,
    Resource? responseDelete,
    List<Product>? listaProduct,
    GlobalKey<FormState>? formKey,
  }) {
    return ProductListState(
      busqueda: busqueda ?? this.busqueda,
      responseDelete: responseDelete,
      listaProduct: listaProduct ?? this.listaProduct,
      response: response,
      formKey: formKey,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [busqueda, response, responseDelete, listaProduct];
}
