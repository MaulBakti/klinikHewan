class rekamMedis {
  int idRekamMedis;
  int idHewan;
  int idPemilik;
  int idPegawai;
  int idObat;
  String keluhan;
  String diagnosa;
  String tglPeriksa;
  // String namaHewan;
  // String namaPemilik;
  // String namaPegawai;
  // String namaObat;

  rekamMedis({
    required this.idRekamMedis,
    required this.idHewan,
    required this.idPemilik,
    required this.idPegawai,
    required this.idObat,
    required this.keluhan,
    required this.diagnosa,
    required this.tglPeriksa,
    // required this.namaHewan,
    // required this.namaPemilik,
    // required this.namaPegawai,
    // required this.namaObat,
  });

  factory rekamMedis.fromJson(Map<String, dynamic> json) {
    return rekamMedis(
      idRekamMedis: json['id_rekam_medis'] ?? 0,
      idHewan: json['id_hewan'] ?? 0,
      idPemilik: json['id_pemilik'] ?? 0,
      idPegawai: json['id_pegawai'] ?? 0,
      idObat: json['id_obat'] ?? 0,
      keluhan: json['keluhan'] ?? '',
      diagnosa: json['diagnosa'] ?? '',
      tglPeriksa: json['tgl_periksa'] ?? '',
      // namaHewan: json['hewan']['nama_hewan'] ?? '',
      // namaPemilik: json['pemilik']['nama_pemilik'] ?? '',
      // namaPegawai: json['pegawai']['nama_pegawai'] ?? '',
      // namaObat: json['obat']['nama_obat'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_rekam_medis': idRekamMedis,
      'id_hewan': idHewan,
      'id_pemilik': idPemilik,
      'id_pegawai': idPegawai,
      'id_obat': idObat,
      'keluhan': keluhan,
      'diagnosa': diagnosa,
      'tgl_periksa': tglPeriksa,
      // 'hewan': {'nama_hewan': namaHewan},
      // 'pemilik': {'nama_pemilik': namaPemilik},
      // 'pegawai': {'nama_pegawai': namaPegawai},
      // 'obat': {'nama_obat': namaObat},
    };
  }
}
