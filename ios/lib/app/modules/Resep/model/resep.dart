class Resep {
  int idResep;
  int idRekamMedis;
  int idObat;
  int jumlahObat;
  String diagnosa;
  String namaObat;

  Resep({
    required this.idResep,
    required this.idRekamMedis,
    required this.idObat,
    required this.jumlahObat,
    required this.diagnosa,
    required this.namaObat,
  });

  factory Resep.fromJson(Map<String, dynamic> json) {
    return Resep(
      idResep: json['id_resep'] ?? 0,
      idRekamMedis: json['id_rekam_medis'] ?? 0,
      idObat: json['id_obat'] ?? 0,
      jumlahObat: json['jumlah_obat'] ?? 0,
      diagnosa: json['rekammedis']['diagnosa'] ?? '',
      namaObat: json['obat']['nama_obat'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_resep': idResep,
      'id_rekam_medis': idRekamMedis,
      'id_obat': idObat,
      'jumlah_obat': jumlahObat,
      'diagnosa': diagnosa,
      'nama_obat': namaObat,
    };
  }
}
