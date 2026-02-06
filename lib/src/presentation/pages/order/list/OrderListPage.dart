import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/list/bloc/OrderListBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/list/bloc/OrderListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/list/bloc/OrderListState.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({super.key});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  OrderListBloc? bloc;

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<OrderListBloc>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue[700],
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: BlocListener<OrderListBloc, OrderListState>(
        listener: (context, state) {
          final response = state.response;
          final responseCliente = state.responseCliente;
          if (responseCliente is Error) {
            AppToast.error(
              'Hubo un problema al consultar los clientes ${responseCliente.message}',
            );
          }
          if (response is Success) {
            if (response.data is bool) {
              AppToast.success('Orden eliminada correctamente');
              bloc?.add(ConsultarOrderListEvent());
            }
          }
          if (response is Error) {
            AppToast.error(response.message);
          }
        },
        child: BlocBuilder<OrderListBloc, OrderListState>(
          builder: (context, state) {
            final response = state.response;
            final responseCliente = state.responseCliente;

            if (response is Loading || responseCliente is Loading) {
              return Center(child: CircularProgressIndicator());
            }

            return Container();
          },
        ),
      ),
    );
  }
}
