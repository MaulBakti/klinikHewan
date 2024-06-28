class Doctor {
  int idDokter;
  String namaDokter;
  String spesialisasi;

  Doctor({
    required this.idDokter,
    required this.namaDokter,
    required this.spesialisasi,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
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
