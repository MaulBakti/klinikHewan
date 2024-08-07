class Hewan {
  int? idHewan;
  int idPemilik;
  String namaHewan;
  String jenisHewan;
  int umur;
  double berat;
  String jenisKelamin;

  Hewan({
    this.idHewan,
    required this.idPemilik,
    required this.namaHewan,
    required this.jenisHewan,
    required this.umur,
    required this.berat,
    required this.jenisKelamin,
  });

  factory Hewan.fromJson(Map<String, dynamic> json) {
    return Hewan(
      idHewan: json['id_hewan'] ?? 0,
      idPemilik: json['id_pemilik'] ?? 0,
      namaHewan: json['nama_hewan'] ?? '',
      jenisHewan: json['jenis_hewan'] ?? '',
      umur: json['umur'] ?? 0,
      berat: json['berat'] ?? 0.0,
      jenisKelamin: json['jenis_kelamin'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_hewan': idHewan,
      'id_pemilik': idPemilik,
      'nama_hewan': namaHewan,
      'jenis_hewan': jenisHewan,
      'umur': umur,
      'berat': berat,
      'jenis_kelamin': jenisKelamin,
    };
  }
}
