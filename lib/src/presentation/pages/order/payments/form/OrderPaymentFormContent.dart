import 'package:ecommerce_prueba/src/presentation/pages/order/payments/form/bloc/OrderPaymentFormBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/payments/form/bloc/OrderPaymentFormState.dart';
import 'package:flutter/material.dart';

class OrderPaymentFormcontent extends StatelessWidget {
  OrderPaymentFormBloc? bloc;
  OrderPaymentFormState state;
  OrderPaymentFormcontent(this.bloc, this.state, {super.key});

  @override
  Widget build(BuildContext context) {
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
                  children: [_infoRow(Icons.receipt_long, 'Venta #', '')],
                ),
              ),
            ],
          ),
        ),
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
