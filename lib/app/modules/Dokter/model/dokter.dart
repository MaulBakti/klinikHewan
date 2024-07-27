class Dokter {
  int idDokter;
  String namaDokter;
  String spesialisasi;

  Dokter({
    required this.idDokter,
    required this.namaDokter,
    required this.spesialisasi,
  });

  factory Dokter.fromJson(Map<String, dynamic> json) {
    return Dokter(
      idDokter: json['id_dokter'] ?? 0,
      namaDokter: json['nama_dokter'] ?? '',
      spesialisasi: json['spesialisasi'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_dokter': idDokter,
      'nama_dokter': namaDokter,
      'spesialisasi': spesialisasi,
    };
  }
}
