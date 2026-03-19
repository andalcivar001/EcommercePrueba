import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:ecommerce_prueba/src/domain/models/OrderPayment.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class OrderPaymentListState extends Equatable {
  final Resource? responseOrden;
  final Resource? responsePagos;
  final bool loading;
  final List<OrderPayment> listaPagos;
  final GlobalKey<FormState>? formKey;

  OrderPaymentListState({
    this.responseOrden,
    this.responsePagos,
    this.loading = false,
    this.formKey,
    this.listaPagos = const [],
  });

  OrderPaymentListState copyWith({
    Resource? responseOrden,
    Resource? responsePagos,
    bool? loading,
    GlobalKey<FormState>? formKey,
    List<OrderPayment>? listaPagos,
  }) {
    return OrderPaymentListState(
      responseOrden: responseOrden ?? this.responseOrden,
      responsePagos: responsePagos ?? this.responsePagos,
      loading: loading ?? this.loading,
      listaPagos: listaPagos ?? this.listaPagos,
      formKey: formKey,
    );
  }

  @override
  List<Object?> get props => [
    responseOrden,
    responsePagos,
    loading,
    listaPagos,
  ];
}
