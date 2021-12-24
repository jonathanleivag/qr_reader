import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchUrl(BuildContext context, ScanModel scan) async {
  if (scan.tipo == 'http') {
    if (!await launch(scan.valor)) throw 'Could not launch ${scan.valor}';
  } else {
    Navigator.pushNamed(context, 'map_view', arguments: scan);
  }
}
