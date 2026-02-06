import 'package:ecommerce_prueba/src/presentation/pages/order/list/bloc/OrderListBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/list/bloc/OrderListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/list/bloc/OrderListState.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultTextField.dart';
import 'package:flutter/material.dart';

class OrderListSearchClient extends StatelessWidget {
  OrderListBloc? bloc;
  OrderListState state;
  OrderListSearchClient(this.bloc, this.state);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        height: 500,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(flex: 8, child: _textBusqueda()),
                SizedBox(width: 10),
                Expanded(flex: 8, child: _textBusqueda()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _textBusqueda() {
    return DefaultTextField(
      label: 'Busqueda de cliente...',
      icon: Icons.search,
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.name,
      autofillHints: const [AutofillHints.name],
      onChanged: (text) {
        bloc?.add(ClienteChangedOrderListEvent(cliente: text));
      },
      validator: (value) {
        if (value == null || value == '' || value.length <= 2) {
          return 'Ingrese por lo menos 2 caracteres para buscar';
        }
        return null;
      },
    );
  }
}
