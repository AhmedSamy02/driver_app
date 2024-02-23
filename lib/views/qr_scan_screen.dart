import 'package:driver_app/components/application_small_appbar.dart';
import 'package:driver_app/models/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:quickalert/quickalert.dart';

class QrScanScreen extends StatefulWidget {
  const QrScanScreen({super.key});

  @override
  State<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen> {
  late Order _order;
  bool _delay = false;
  @override
  void didChangeDependencies() {
    _order = ModalRoute.of(context)!.settings.arguments as Order;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(child: ApplicationSmallAppbar()),
          Expanded(
            flex: 7,
            child: MobileScanner(
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;

                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.loading,
                  title: 'QR Code Scanned',
                  text: 'Processing...',
                  barrierDismissible: false,
                );
                Future.delayed(Duration(seconds: 5), () {
                  Navigator.pop(context);
                });
              },
              controller: MobileScannerController(
                detectionSpeed: DetectionSpeed.noDuplicates,
                facing: CameraFacing.back,
                torchEnabled: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}
