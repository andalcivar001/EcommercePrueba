import 'dart:typed_data';

import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class OrderListState extends Equatable {
  final String busqueda;
  final Resource? response;
  final Resource? responseDelete;
  final List<Order>? listaOrder;
  final GlobalKey<FormState>? formKey;
  final Uint8List? pdfBytes;
  final bool loading;

  OrderListState({
    this.response,
    this.responseDelete,
    this.formKey,
    this.busqueda = '',
    this.listaOrder,
    this.pdfBytes,
    this.loading = false,
  });

  OrderListState copyWith({
    GlobalKey<FormState>? formKey,
    Resource? response,
    Resource? responseDelete,
    String? busqueda,
    List<Order>? listaOrder,
    bool? loading,
    Uint8List? pdfBytes,
  }) {
    return OrderListState(
      busqueda: busqueda ?? this.busqueda,
      response: response,
      responseDelete: response ?? this.responseDelete,
      formKey: formKey,
      listaOrder: listaOrder ?? this.listaOrder,
      loading: loading ?? this.loading,
      pdfBytes: pdfBytes ?? this.pdfBytes,
    );
  }

  @override
  List<Object?> get props => [
    response,
    responseDelete,
    busqueda,
    listaOrder,
    loading,
    pdfBytes,
  ];
}
