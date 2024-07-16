class Pemilik {
  int idPemilik;
  String namaPemilik;
  String alamat;
  String? password;
  String jabatan;
  String noTelp;

  Pemilik({
    required this.idPemilik,
    required this.namaPemilik,
    required this.alamat,
    required this.jabatan,
    required this.password,
    required this.noTelp,
  });

  factory Pemilik.fromJson(Map<String, dynamic> json) {
    return Pemilik(
      idPemilik: json['id_pemilik'] ?? 0,
      namaPemilik: json['username'] ?? '',
      password: json['password'] ?? '',
      jabatan: json['jabatan'] ?? '',
      alamat: json['alamat'] ?? '',
      noTelp: json['no_telp'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_pemilik': idPemilik,
      'username': namaPemilik,
      'password': password,
      'jabatan': jabatan,
      'alamat': alamat,
      'no_telp': noTelp,
    };
  }
}
