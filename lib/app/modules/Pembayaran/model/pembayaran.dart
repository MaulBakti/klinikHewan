class Pembayaran {
  String? idPembayaran; // id_pembayaran
  String? idRekamMedis; // id_rekam_medis
  DateTime? tanggalPembayaran; // tgl_pembayaran
  double? jumlahPembayaran; // jumlah_pembayaran
  String? buktiPembayaran; // bukti_pembayaran

  Pembayaran({
    this.idPembayaran,
    this.idRekamMedis,
    this.tanggalPembayaran,
    this.jumlahPembayaran,
    this.buktiPembayaran,
  });

  // Factory method untuk membuat objek dari JSON
  factory Pembayaran.fromJson(Map<String, dynamic> json) {
    return Pembayaran(
      idPembayaran: json['id_pembayaran'] as String?,
      idRekamMedis: json['id_rekam_medis'] as String?,
      tanggalPembayaran: DateTime.parse(json['tanggal_pembayaran']),
      jumlahPembayaran: (json['jumlah_pembayaran'] as num?)?.toDouble(),
      buktiPembayaran: json['bukti_pembayaran'] as String?,
    );
  }

  // Method untuk mengkonversi objek menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'id_pembayaran': idPembayaran,
      'id_rekam_medis': idRekamMedis,
      'tgl_pembayaran': tanggalPembayaran?.toIso8601String(),
      'jumlah_pembayaran': jumlahPembayaran,
      'bukti_pembayaran': buktiPembayaran,
    };
  }
}
