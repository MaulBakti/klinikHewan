class Hewan {
  String? id_hewan;
  String? id_pemilik;
  String? nama_hewan;
  String? jenis_hewan;
  String? umur;
  String? berat;
  String? jenis_kelamin;

  Hewan(
      {required this.id_hewan,
      this.id_pemilik,
      this.nama_hewan,
      this.jenis_hewan,
      this.umur,
      this.berat,
      this.jenis_kelamin});

  factory Hewan.fromJson(Map<String, dynamic> json) {
    return Hewan(
        id_hewan: json['id_hewan'],
        id_pemilik: json['id_pemilik'],
        nama_hewan: json['nama_hewan'],
        jenis_hewan: json['jenis_hewan'],
        umur: json['umur'],
        berat: json['berat'],
        jenis_kelamin: json['jenis_kelamin']);
  }
}
