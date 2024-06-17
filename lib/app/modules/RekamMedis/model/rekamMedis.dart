import 'package:flutter/material.dart';

class rekamMedis {
  String? id_rekam_medis;
  String? id_hewan;
  String? id_pemilik;
  String? id_pegawai;
  String? id_obat;
  String? keluhan;
  String? diagnosa;
  String? tgl_periksa;

  rekamMedis(
      {this.id_rekam_medis,
      this.id_hewan,
      this.id_pemilik,
      this.id_pegawai,
      this.id_obat,
      this.keluhan,
      this.diagnosa,
      this.tgl_periksa});

  factory rekamMedis.fromJson(Map<String, dynamic> json) {
    return rekamMedis(
        id_rekam_medis: json['id_rekam_medis'],
        id_hewan: json['id_hewan'],
        id_pemilik: json['id_pemilik'],
        id_pegawai: json['id_pegawai'],
        id_obat: json['id_obat'],
        keluhan: json['keluhan'],
        diagnosa: json['diagnosa'],
        tgl_periksa: json['tgl_periksa']);
  }
}
