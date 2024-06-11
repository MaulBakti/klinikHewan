import 'dart:ffi';

import 'package:flutter/material.dart';

class pemilik {
  Int? id_pemilik;
  String? nama_pemilik;
  String? password;
  String? alamat;
  String? no_telp;

  pemilik({
    this.id_pemilik,
    this.nama_pemilik,
    this.password,
    this.alamat,
    this.no_telp,
  });
}
