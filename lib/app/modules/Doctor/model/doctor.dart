class Dokter {
  String? id_dokter;
  String? nama_dokter;
  String? spesialisasi;

  Dokter({required this.id_dokter, this.nama_dokter, this.spesialisasi});

  factory Dokter.fromJson(Map<String, dynamic> json) {
    return Dokter(
        id_dokter: json['id_dokter'],
        nama_dokter: json['nama_dokter'],
        spesialisasi: json['spesialisasi']);
  }
}
