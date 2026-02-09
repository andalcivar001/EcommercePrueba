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

  OrderListState({
    this.response,
    this.responseDelete,
    this.formKey,
    this.busqueda = '',
    this.listaOrder,
  });

  OrderListState copyWith({
    GlobalKey<FormState>? formKey,
    Resource? response,
    Resource? responseDelete,
    String? busqueda,
    List<Order>? listaOrder,
  }) {
    return OrderListState(
      busqueda: busqueda ?? this.busqueda,
      response: response,
      responseDelete: response ?? this.responseDelete,
      formKey: formKey,
      listaOrder: listaOrder ?? this.listaOrder,
    );
  }

  @override
  List<Object?> get props => [response, responseDelete, busqueda, listaOrder];
}
