import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:flutter/material.dart';

class OrderPaymentListContent extends StatelessWidget {
  Order orden;
  OrderPaymentListContent({required this.orden, super.key});

  @override
  Widget build(BuildContext context) {
    orden.totalPagado = 60;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _header(context),
            Expanded(
              child: Stack(
                children: [
                  _cardPrincipal(),
                  _cardOrden(
                    chipEstado: _chipEstado(),
                    nombre: orden.cliente?.nombre ?? 'n/a',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 25),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              'Detalle de Pagos',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardPrincipal() {
    return Card(
      elevation: 1,
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Padding(padding: EdgeInsets.all(20)),
      ),
    );
  }

  Widget _cardOrden({required Widget chipEstado, required String nombre}) {
    return Positioned(
      top: 10,
      left: 5,
      right: 5,
      child: Card(
        elevation: 2,

        color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 3, vertical: 10),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.blueAccent,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nombre,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.receipt_long,
                                size: 20,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Venta #${orden.secuencia.toString()}',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  chipEstado,
                ],
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.grey.shade300),
                ),
              ),
              SizedBox(height: 5),
              _barraProgresiva(),
              SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(color: Colors.grey.shade200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: _cardValores(
                        icon: Icons.attach_money,
                        color: Colors.blue,
                        label: 'Total Venta',
                        value: '\$${orden.total.toStringAsFixed(2)}',
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: _cardValores(
                        icon: Icons.check,
                        color: Colors.green,
                        label: 'Total Pagado',
                        value:
                            '\$${(orden.totalPagado ?? 0).toStringAsFixed(2)}',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.grey.shade200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: _cardValores(
                        icon: Icons.error_outline,
                        color: Colors.orange,
                        label: 'Pendiente',
                        value:
                            '\$${(orden.total - (orden.totalPagado ?? 0)).toStringAsFixed(2)}',
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: _cardValores(
                        icon: Icons.percent,
                        color: Colors.indigo,
                        label: '% Pagado',
                        value: ((orden.totalPagado ?? 0) * 100 / orden.total)
                            .toStringAsFixed(2),
                      ),
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

  Widget _chipEstado() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Pago parcial',
            style: TextStyle(
              color: Colors.orange,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 3),
          Icon(Icons.arrow_forward_ios, size: 17, color: Colors.orange),
        ],
      ),
    );
  }

  Widget _barraProgresiva() {
    double saldo = orden.total - (orden.totalPagado ?? 0);
    double porcSaldo = (orden.totalPagado ?? 0) * 100 / orden.total;
    Color color = Colors.blue;
    if (porcSaldo >= 0 && porcSaldo <= 30) {
      color = Colors.red;
    } else if (porcSaldo >= 31 && porcSaldo <= 70) {
      color = Colors.orange;
    } else {
      color = Colors.green;
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Pago: \$${(orden.totalPagado ?? 0).toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 2),
              Text('| Saldo. \$${saldo.toStringAsFixed(2)}'),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '\$${(orden.totalPagado ?? 0).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(' | \$${orden.total.toStringAsFixed(2)}'),
                  ],
                ),
              ),
            ],
          ),
          LinearProgressIndicator(
            value: porcSaldo / 100,
            backgroundColor: Colors.grey.shade400,
            color: color,
            minHeight: 10,
            borderRadius: BorderRadius.circular(50),
          ),
        ],
      ),
    );
  }

  Widget _cardValores({
    required IconData icon,
    required Color color,
    required String label,
    required String value,
  }) {
    return Card(
      elevation: 1,
      color: Colors.white,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: color,
              child: Icon(icon, color: Colors.white, size: 15),
            ),
            SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoDetalle() {
    return ListView.builder(
      itemCount: orden.pagos.length,
      itemBuilder: (context, index) {
        return Container();
      },
    );
  }
}
