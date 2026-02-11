import 'package:ecommerce_prueba/src/presentation/pages/order/form/OrderFormContent.dart';
import 'package:flutter/material.dart';

class OrderFormPage extends StatefulWidget {
  const OrderFormPage({super.key});

  @override
  State<OrderFormPage> createState() => _OrderFormPageState();
}

class _OrderFormPageState extends State<OrderFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: OrderFormContent());
  }
}
