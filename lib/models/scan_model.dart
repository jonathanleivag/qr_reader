import 'package:google_maps_flutter/google_maps_flutter.dart';

class ScanModel {
  int? id;
  String? tipo;
  late String valor;

  LatLng getLatLng() {
    final latLng = valor.substring(4).split(',');
    final lat = double.parse(latLng[0]);
    final lng = double.parse(latLng[1]);
    return LatLng(lat, lng);
  }

  ScanModel({this.id, this.tipo, required this.valor}) {
    if (valor.contains('http')) {
      tipo = 'http';
    } else {
      tipo = 'geo';
    }
  }

  ScanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tipo = json['tipo'];
    valor = json['valor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tipo'] = tipo;
    data['valor'] = valor;
    return data;
  }
}
