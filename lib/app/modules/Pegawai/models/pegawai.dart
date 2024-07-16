class Pegawai {
  final int idPegawai;
  final String namaPegawai;
  final String? password; //optional
  final String jabatan;
  final String alamat;
  final String noTelp;

  Pegawai({
    required this.idPegawai,
    required this.namaPegawai,
    this.password,
    required this.jabatan,
    required this.alamat,
    required this.noTelp,
  });

  factory Pegawai.fromJson(Map<String, dynamic> json) {
    return Pegawai(
      idPegawai: json['id_pegawai'] ?? 0,
      namaPegawai: json['username'] ?? '',
      jabatan: json['jabatan'] ?? '',
      password: json['password'] ?? '',
      alamat: json['alamat'] ?? '',
      noTelp: json['no_telp'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_pegawai': idPegawai,
      'username': namaPegawai,
      'jabatan': jabatan,
      'password': password,
      'alamat': alamat,
      'no_telp': noTelp,
    };
  }
}
