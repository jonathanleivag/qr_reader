import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/models/models.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'ScanDB.db');
    print(path);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) => _onCreate(db, version),
    );
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE Scans(
          id INTEGER PRIMARY KEY,
          tipo TEXT,
          valor TEXT
        );
     ''');
  }

  Future<int> newScanRaw(ScanModel newScan) async {
    final db = await database;
    final result = await db.rawInsert('''
      INSERT INTO Scans(id, tipo, valor)
      VALUE
      (${newScan.id}, ${newScan.tipo}, ${newScan.valor});
     ''');

    return result;
  }

  Future<int> newScan(ScanModel newScan) async {
    final db = await database;
    final result = await db.insert('Scans', newScan.toJson());
    return result;
  }

  Future<ScanModel> getScanById(int id) async {
    final db = await database;
    final result = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty
        ? ScanModel.fromJson(result.first)
        : ScanModel(valor: 'No tiene valor');
  }

  Future<List<ScanModel>> getScanAll() async {
    final db = await database;
    final result = await db.query('Scans');
    return result.isNotEmpty
        ? result.map((scan) => ScanModel.fromJson(scan)).toList()
        : <ScanModel>[];
  }

  Future<List<ScanModel>> getScanType(String type) async {
    final db = await database;
    final result = await db.query('Scans', where: 'tipo=?', whereArgs: [type]);
    return result.isNotEmpty
        ? result.map((scan) => ScanModel.fromJson(scan)).toList()
        : <ScanModel>[];
  }

  Future<int> updateScan(ScanModel newScan) async {
    final db = await database;
    final result = await db.update('Scans', newScan.toJson(),
        where: 'id=?', whereArgs: [newScan.id]);
    return result;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final result = await db.delete('Scans', where: 'id=?', whereArgs: [id]);
    return result;
  }

  Future<int> deleteAllScan() async {
    final db = await database;
    final result = await db.delete('Scans');
    return result;
  }
}
