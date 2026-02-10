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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            dense: true,
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Venta #', style: TextStyle(fontSize: 15)),
                Text(
                  order.secuencia.toString(),
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            trailing: _chipId(estado),
          ),
          _divider(),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Text('Cliente:', style: TextStyle(fontSize: 13)),
                SizedBox(width: 2),

                Text(
                  order.cliente?.nombre ?? '',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 10),
              Text('Total', style: TextStyle(fontSize: 13)),
              SizedBox(width: 2),
              _textTotal(),
              SizedBox(width: 20),
              Text('Estado', style: TextStyle(fontSize: 13)),
              SizedBox(width: 2),
              _textEstado(estado),
              SizedBox(width: 20),
              Text('Fecha', style: TextStyle(fontSize: 13)),
              SizedBox(width: 2),

              Text(
                '2026-02-10',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chipId(String estado) {
    Color color = Colors.blue;
    IconData icon = Icons.add;
    switch (order.estado) {
      case 'N':
        color = Colors.yellow.shade700;
        icon = Icons.new_label;
        break;
      case 'X':
        color = Colors.red;
        icon = Icons.close;
        break;
      case 'P':
        color = Colors.green;
        icon = Icons.check_circle;

        break;
    }
    return SizedBox(
      width: 130,
      height: 28,

      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(99),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            Text(
              estado.toUpperCase(),
              style: TextStyle(
                color: order.estado == 'N' ? Colors.black : Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Divider(
      height: 1, // espacio total que ocupa
      thickness: 1, // ancho de la linea
      color: Colors.grey,
      indent: 10, // margen izquierdo
      endIndent: 10, // margen derecho
    );
  }

  Widget _textTotal() {
    final double total = order.total ?? 0;
    return Text(
      '\$${total.toString()}',
      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
    );
  }

  Widget _textEstado(String estado) {
    return Text(
      estado,
      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
    );
  }
}
