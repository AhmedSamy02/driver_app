import 'package:driver_app/components/application_small_appbar.dart';
import 'package:driver_app/cubits/finish_order_cubit/finish_order_cubit.dart';
import 'package:driver_app/models/order.dart';
import 'package:driver_app/services/send_qr_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              onDetect: (capture) async {
                final barcode = capture.barcodes[0];

                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.loading,
                  title: 'QR Code Scanned',
                  text: 'Processing...',
                  barrierDismissible: false,
                );
                String response = await SendQrCode.sendQrCode(
                    qrCode: barcode.rawValue!,
                    vehicleId: _order.vehicleId!,
                    orderId: _order.orderId!);
                Navigator.pop(context);
                if (response == 'Success') {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    title: 'Congratulations!',
                    text: 'You have successfully delivered the order',
                    confirmBtnText: 'Okay',
                    showConfirmBtn: true,
                    onConfirmBtnTap: () {
                      BlocProvider.of<FinishOrderCubit>(context)
                          .orderSuccess('Completed');
                      Navigator.pop(context);
                    },
                  );
                } else {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: 'Error',
                    text: response,
                    confirmBtnText: 'Okay',
                    showConfirmBtn: true,
                    onConfirmBtnTap: () {},
                  );
                }
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
