import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/payments/form/bloc/OrderPaymentFormBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/payments/form/bloc/OrderPaymentFormState.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderPaymentFormcontent extends StatelessWidget {
  OrderPaymentFormBloc? bloc;
  OrderPaymentFormState state;
  OrderPaymentFormcontent(this.bloc, this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    final Order? orden = state.responseOrden is Success
        ? (state.responseOrden as Success).data as Order
        : null;
    String fecha = '', nombreCliente = '';
    int secuencia = 0, cantDetalles = 0;
    double total = 0;
    if (orden != null) {
      secuencia = orden.secuencia ?? 0;
      cantDetalles = orden.detalles.length;
      fecha = DateFormat('yyyy-MM-dd HH:mm').format(orden.fecha);
      nombreCliente = orden.cliente?.nombre ?? '';
      total = orden.total;
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(14),
          decoration: BoxDecoration(color: Color(0xffF5F7FA)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  children: [
                    _header(context),
                    SizedBox(height: 10),
                    _infoRow(
                      Icons.receipt_long,
                      'Venta #',
                      secuencia.toString(),
                    ),
                    SizedBox(height: 8),
                    _infoRow(Icons.calendar_today, 'Fecha', fecha),
                    SizedBox(height: 8),
                    _infoRow(Icons.person, 'Cliente', nombreCliente),
                    SizedBox(height: 8),
                    _infoRow(
                      Icons.production_quantity_limits,
                      'Total',
                      '\$${total.toStringAsFixed(2)}',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(color: Color(0xff2F5DFF)),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: EdgeInsetsGeometry.all(6),
              child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
            ),
          ),
          SizedBox(width: 12),
          Text(
            'Formulario de pago',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey),
        Text(' $label: ', style: TextStyle(fontWeight: FontWeight.bold)),
        Expanded(child: Text(value)),
      ],
    );
  }
}
