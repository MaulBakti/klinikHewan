class Obat {
  int idObat;
  String namaObat;
  String keterangan;

  Obat({
    required this.idObat,
    required this.namaObat,
    required this.keterangan,
  });

  factory Obat.fromJson(Map<String, dynamic> json) {
    return Obat(
      idObat: json['id_obat'] ?? 0,
      namaObat: json['nama_obat'] ?? 0,
      keterangan: json['keterangan'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_obat': idObat,
      'nama_obat': namaObat,
      'keterangan': keterangan,
    };
  }
}
