import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderViewPage extends StatelessWidget {
  final Order order;

  const OrderViewPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.7,
      maxChildSize: 0.85,
      expand: false,
      builder: (_, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xffF6F7FB),
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),

              /// indicador draggable
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              const SizedBox(height: 15),

              /// titulo
              Text(
                "Venta #${order.secuencia}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      /// CARD INFORMACION
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 6,
                              color: Colors.black.withOpacity(0.05),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _infoRow(
                              Icons.calendar_today,
                              "Fecha",
                              DateFormat(
                                'yyyy-MM-dd HH:mm',
                              ).format(order.fecha),
                            ),
                            const SizedBox(height: 8),
                            _infoRow(
                              Icons.person,
                              "Cliente",
                              order.cliente?.nombre ?? '',
                            ),
                            const SizedBox(height: 8),
                            _infoRow(
                              Icons.badge,
                              "Usuario",
                              order.usuario?.nombre ?? '',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 15),

                      /// CABECERA PRODUCTOS
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Text(
                                "Producto",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Cant.",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                "P.U",
                                textAlign: TextAlign.right,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                "Total",
                                textAlign: TextAlign.right,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Divider(),

                      /// LISTA PRODUCTOS
                      Expanded(
                        child: order.detalles.isEmpty
                            ? const Center(child: Text("No hay productos"))
                            : ListView.builder(
                                controller: scrollController,
                                itemCount: order.detalles.length,
                                itemBuilder: (_, index) {
                                  final detalle = order.detalles[index];
                                  final total =
                                      detalle.cantidad * detalle.precio;

                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Text(
                                            detalle.producto?.descripcion ?? '',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            detalle.cantidad.toString(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            "\$${detalle.precio.toStringAsFixed(2)}",
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            "\$${total.toStringAsFixed(2)}",
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                      ),

                      const Divider(),

                      /// TOTALES
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          children: [
                            _totalRow(
                              "Subtotal",
                              "\$${order.subtotal.toStringAsFixed(2)}",
                            ),
                            const SizedBox(height: 4),
                            _totalRow(
                              "Impuestos",
                              "\$${order.impuestos.toStringAsFixed(2)}",
                            ),

                            const SizedBox(height: 10),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: _totalRow(
                                "TOTAL",
                                "\$${order.total.toStringAsFixed(2)}",
                                isTotal: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
        Expanded(child: Text(value)),
      ],
    );
  }

  Widget _totalRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 13,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
