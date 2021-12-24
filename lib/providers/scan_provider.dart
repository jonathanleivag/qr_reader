import 'package:flutter/material.dart';
import 'package:qr_reader/models/models.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String typeScan = 'http';

  Future<ScanModel> newScan(String value) async {
    final newScan = ScanModel(valor: value);
    final id = await DBProvider.db.newScan(newScan);
    newScan.id = id;
    if (typeScan == newScan.tipo) {
      scans.add(newScan);
      notifyListeners();
    }
    return newScan;
  }

  Future<void> loadScans() async {
    final scans = await DBProvider.db.getScanAll();
    this.scans = [...scans];
    notifyListeners();
  }

  Future<void> loadForTypeScans(String type) async {
    final scans = await DBProvider.db.getScanType(type);
    this.scans = [...scans];
    typeScan = type;
    notifyListeners();
  }

  Future<void> deleteAllScan() async {
    await DBProvider.db.deleteAllScan();
    scans = [];
    notifyListeners();
  }

  Future<void> deleteScan(int id) async {
    await DBProvider.db.deleteScan(id);
    loadForTypeScans(typeScan);
  }
}
