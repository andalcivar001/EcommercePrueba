import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:ecommerce_prueba/src/domain/models/OrderPayment.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/payments/list/OrderPaymentListContent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/payments/list/bloc/OrderPaymentListBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/payments/list/bloc/OrderPaymentListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/payments/list/bloc/OrderPaymentListState.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPaymentListPage extends StatefulWidget {
  const OrderPaymentListPage({super.key});

  @override
  State<OrderPaymentListPage> createState() => _OrderPaymentListPageState();
}

class _OrderPaymentListPageState extends State<OrderPaymentListPage> {
  String idOrden = '';
  OrderPaymentListBloc? bloc;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc?.add(InitOrderPaymentListEvent(idOrden: idOrden));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      idOrden = ModalRoute.of(context)?.settings.arguments as String;
    }
    bloc = BlocProvider.of<OrderPaymentListBloc>(context);
    return Scaffold(
      body: Center(
        child: BlocListener<OrderPaymentListBloc, OrderPaymentListState>(
          listener: (context, state) {
            final responseOrden = state.responseOrden;
            final responsePagos = state.responsePagos;
            final responseDelete = state.responseDelete;
            if (responseOrden is Error) {
              AppToast.error(
                'Hubo un problema al consultar la orden ${responseOrden.message}',
              );
            }

            if (responsePagos is Error) {
              AppToast.error(
                'Hubo un problema al consultar los pagos ${responsePagos.message}',
              );
            }
            if (responseDelete is Error) {
              AppToast.error(
                'Hubo un problema al eliminar el apgo ${responseDelete.message}',
              );
            } else if (responseDelete is Success) {
              AppToast.success('Pago eliminado correctamente');
              bloc?.add(InitOrderPaymentListEvent(idOrden: idOrden));
            }
          },
          child: BlocBuilder<OrderPaymentListBloc, OrderPaymentListState>(
            builder: (context, state) {
              final responseOrden = state.responseOrden;
              final responsePagos = state.responsePagos;
              final responseDelete = state.responseDelete;
              return Stack(
                children: [
                  if (responseOrden is Success && responsePagos is Success)
                    OrderPaymentListContent(
                      bloc,
                      orden: responseOrden.data as Order,
                      listaPagos: responsePagos.data as List<OrderPayment>,
                    ),
                  if (state.loading || responseDelete is Loading)
                    Positioned.fill(
                      child: ColoredBox(
                        color: Color(0x66000000),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
