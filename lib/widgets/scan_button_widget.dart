import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/providers.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanButtonWidget extends StatelessWidget {
  const ScanButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _onPressed(context),
      elevation: 0,
      child: const Icon(Icons.filter_center_focus),
    );
  }

  Future _onPressed(BuildContext context) async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#3d8bef', 'Cancelar', false, ScanMode.QR);
    if (barcodeScanRes == '-1') return;
    final scanProvider = Provider.of<ScanProvider>(context, listen: false);
    final scan = await scanProvider.newScan(barcodeScanRes);
    launchUrl(context, scan);
  }
}
