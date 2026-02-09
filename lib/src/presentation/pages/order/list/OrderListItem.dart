import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/list/bloc/OrderListBloc.dart';
import 'package:flutter/material.dart';

class OrderListItem extends StatelessWidget {
  OrderListBloc? bloc;
  Order order;
  OrderListItem(this.bloc, this.order);

  @override
  Widget build(BuildContext context) {
    String estado;
    switch (order.estado) {
      case 'N':
        estado = 'Registrado';
        break;
      case 'X':
        estado = 'Anulado';
        break;
      case 'P':
        estado = 'Pagado';
        break;
      default:
        estado = 'Otro';
    }
    // order.estado =='N' ? 'Ingresado' :
    return Card(
      margin: EdgeInsets.only(top: 10, left: 5, right: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                leading: Text(
                  order.cliente?.nombre ?? '',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                trailing: _chipId(),
              ),
            ],
          ),
          SizedBox(height: 3),
          _divider(),
          SizedBox(height: 4),
          Text(
            order.fecha.toString(),
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Total:', style: TextStyle(fontSize: 14)),
              _textTotal(),
              Text('Estado', style: TextStyle(fontSize: 14)),
              _textEstado(estado!),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chipId() {
    Color color = Colors.blue;
    switch (order.estado) {
      case 'N':
        color = Colors.blue;
        break;
      case 'X':
        color = Colors.red;
        break;
      case 'P':
        color = Colors.greenAccent;
        break;
    }
    return Container(
      padding: EdgeInsets.only(right: 5, left: 5),
      width: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(order.id!, style: TextStyle(color: Colors.white)),
    );
  }

  Widget _divider() {
    return Divider(
      height: 20, // espacio total que ocupa
      thickness: 1, // ancho de la linea
      color: Colors.grey,
      indent: 10, // margen izquierdo
      endIndent: 10, // margen derecho
    );
  }

  Widget _textTotal() {
    return Text(
      '\$${order.total.toString()}',
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    );
  }

  Widget _textEstado(String estado) {
    return Text(
      estado,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    );
  }
}
