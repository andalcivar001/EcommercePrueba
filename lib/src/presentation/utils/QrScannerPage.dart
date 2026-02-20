import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:vibration/vibration.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  bool _isScanned = false;
  final MobileScannerController controller = MobileScannerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /// 📷 CAMARA
          MobileScanner(
            controller: controller,
            onDetect: (barcodeCapture) async {
              if (_isScanned) return; // 🔥 BLOQUEA DOBLE LECTURA

              final barcode = barcodeCapture.barcodes.first;
              final String? code = barcode.rawValue;

              if (code != null) {
                _isScanned = true;
                try {
                  final hasVibrator = await Vibration.hasVibrator();
                  if (hasVibrator == true) {
                    Vibration.vibrate(
                      duration: 200,
                    ); // sin await, y duración razonable
                  }
                } catch (ex) {
                  print('HUBO PROBLEMA CON LA VIBRACION $ex');
                }

                await controller.stop();

                await Future.delayed(const Duration(milliseconds: 150));
                Navigator.pop(context, code);
              }
            },
          ),

          /// 🔲 OVERLAY OSCURO
          _buildOverlay(),

          /// 🔝 HEADER
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  const Text(
                    "Escanear QR",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 48),
                ],
              ),
            ),
          ),

          /// 📝 TEXTO INFERIOR
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 60),
              child: Text(
                "Coloca el código QR dentro del recuadro",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Overlay con hueco central
  Widget _buildOverlay() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final scanSize = 250.0;

        return Stack(
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6),
                BlendMode.srcOut,
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      backgroundBlendMode: BlendMode.dstOut,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: scanSize,
                      height: scanSize,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Bordes del scanner
            Align(
              alignment: Alignment.center,
              child: Container(
                width: scanSize,
                height: scanSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white, width: 3),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
