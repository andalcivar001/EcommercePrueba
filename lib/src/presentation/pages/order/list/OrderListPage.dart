import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/list/OrderListItem.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/list/bloc/OrderListBloc.dart';
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
          if (response is Error) {
            AppToast.error(response.message);
          }
        },
        child: BlocBuilder<OrderListBloc, OrderListState>(
          builder: (context, state) {
            final response = state.response;
            if (response is Success) {
              List<Order> listaOrder = response.data as List<Order>;

              return Padding(
                padding: EdgeInsetsGeometry.all(16),
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        'Ventas',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.5,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      width: double.infinity,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Color(0xFF1E3C72),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Container(
                      child: listaOrder.isEmpty
                          ? Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                'No hay ventas creadas',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : Container(),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: listaOrder.length,
                        itemBuilder: (context, index) {
                          return OrderListItem(bloc, state);
                        },
                      ),
                    ),
                  ],
                ),
              );
            }

            if (response is Loading) {
              return Center(child: CircularProgressIndicator());
            }
            return Container();
          },
        ),
      ),
    );
  }
}
