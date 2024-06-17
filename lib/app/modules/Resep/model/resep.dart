import 'package:flutter/foundation.dart';

class Resep {
  String? id_resep;
  String? id_rekam_medis;
  String? id_obat;
  String? jumlah_obat;

  Resep(
      {required this.id_resep,
      this.id_rekam_medis,
      this.id_obat,
      this.jumlah_obat});

  factory Resep.fromJson(Map<String, dynamic> json) {
    return Resep(
        id_resep: json['id_resep'],
        id_rekam_medis: json['id_rekam_medis'],
        id_obat: json['id_obat'],
        jumlah_obat: json['jumlah_obat']);
  }
}
