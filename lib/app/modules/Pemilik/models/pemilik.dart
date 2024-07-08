class Pemilik {
  int idPemilik;
  String namaPemilik;
  String alamat;
  String noTelp;

  Pemilik({
    required this.idPemilik,
    required this.namaPemilik,
    required this.alamat,
    required this.noTelp,
  });

  factory Pemilik.fromJson(Map<String, dynamic> json) {
    return Pemilik(
      idPemilik: json['id_pemilik'] ?? 0,
      namaPemilik: json['username'] ?? '',
      alamat: json['alamat'] ?? '',
      noTelp: json['no_telp'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_pemilik': idPemilik,
      'username': namaPemilik,
      'alamat': alamat,
      'no_telp': noTelp,
    };
  }
}
