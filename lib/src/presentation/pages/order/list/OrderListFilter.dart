import 'package:collection/collection.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/list/bloc/OrderListBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/list/bloc/OrderListState.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class OrderListFilter extends StatelessWidget {
  OrderListBloc? bloc;
  OrderListState state;

  OrderListFilter(this.bloc, this.state);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
