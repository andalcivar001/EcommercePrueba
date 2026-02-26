import 'dart:typed_data';
import 'package:injectable/injectable.dart';
import 'package:ecommerce_prueba/src/domain/models/Order.dart' as ord;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

@injectable
class OrderPdfService {
  Future<Uint8List> generaVenta(ord.Order orden) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'MI TIENDA',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Text('Venta N° ${orden.secuencia}'),
              pw.SizedBox(height: 10),
              pw.Text('Fecha ${DateFormat('yyyy-MM-dd').format(orden.fecha)}'),
              pw.SizedBox(height: 10),
              pw.Text('Cliente ${orden.cliente!.nombre}'),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Prod.'),
                  pw.Text('Cant.'),
                  pw.Text('P. U.'),
                ],
              ),
              pw.Divider(),
              ...orden.detalles.map(
                (detalle) => pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(detalle.producto!.descripcion),
                    pw.Text(detalle.cantidad.toString()),
                    pw.Text(detalle.precio.toStringAsFixed(2)),
                  ],
                ),
              ),
              pw.Divider(),
              pw.Text('Subtotal: \$${orden.subtotal.toStringAsFixed(2)}'),
              pw.Text('Impuestos: \$${orden.impuestos.toStringAsFixed(2)}'),
              pw.Text(
                'Total: \$${orden.total.toStringAsFixed(2)}',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
