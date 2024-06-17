class Obat {
  String? id_obat;
  String? nama_obat;
  String? keterangan;

  Obat({required this.id_obat, this.nama_obat, this.keterangan});

  factory Obat.fromJson(Map<String, dynamic> json) {
    return Obat(
        id_obat: json['id_obat'],
        nama_obat: json['nama_obat'],
        keterangan: json['keterangan']);
  }
}
