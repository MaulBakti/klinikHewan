class Pembayaran {
  int? idPembayaran;
  int? idRekamMedis;
  int? idPemilik;
  int? idHewan;
  int? idDokter;
  int? idAppointment;
  int? idObat;
  int? idResep;
  String? tanggalPembayaran; // Diganti menjadi tipe String
  String? jumlahPembayaran; // Diganti menjadi tipe String
  String? buktiPembayaran;
  // Exclude
  String? namaPemilik;
  String? namaHewan;
  String? namaDokter;
  String? catatan;
  String? keluhan;
  String? namaObat;
  int? jumlahObat;

  Pembayaran({
    this.idPembayaran,
    this.idRekamMedis,
    this.idPemilik,
    this.idHewan,
    this.idDokter,
    this.idAppointment,
    this.idObat,
    this.idResep,
    this.tanggalPembayaran,
    this.jumlahPembayaran,
    this.buktiPembayaran,
    // Exclude
    this.namaPemilik,
    this.namaHewan,
    this.namaDokter,
    this.catatan,
    this.keluhan,
    this.namaObat,
    this.jumlahObat,
  });

  // Factory method untuk membuat objek dari JSON
  factory Pembayaran.fromJson(Map<String, dynamic> json) {
    return Pembayaran(
      idPembayaran: json['id_pembayaran'],
      idRekamMedis: json['id_rekam_medis'],
      idPemilik: json['id_pemilik'],
      idHewan: json['id_hewan'],
      idDokter: json['id_dokter'],
      idAppointment: json['id_appointment'],
      idObat: json['id_obat'],
      idResep: json['id_resep'],
      tanggalPembayaran: json['tgl_pembayaran'],
      jumlahPembayaran: json['jumlah_pembayaran'].toString(),
      buktiPembayaran: json['bukti_pembayaran'],
      namaPemilik: json['pemilik'] != null ? json['pemilik']['username'] : '',
      namaHewan: json['hewan'] != null ? json['hewan']['nama_hewan'] : '',
      namaDokter: json['dokter'] != null ? json['dokter']['nama_dokter'] : '',
      catatan:
          json['appointment'] != null ? json['appointment']['catatan'] : '',
      keluhan: (json['rekam_medis'] != null &&
              json['rekam_medis']['keluhan'] != null)
          ? json['rekam_medis']['keluhan']
          : 'Tidak ada keluhan',
      namaObat: json['obat'] != null ? json['obat']['nama_obat'] : '',
      jumlahObat: json['resep'] != null ? json['resep']['jumlah_obat'] : 0,
    );
  }

  // Method untuk mengkonversi objek menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'id_pembayaran': idPembayaran,
      'id_rekam_medis': idRekamMedis,
      'id_hewan': idHewan,
      'id_pemilik': idPemilik,
      'id_dokter': idDokter,
      'id_obat': idObat,
      'id_appointment': idAppointment,
      'id_resep': idResep,
      'tgl_pembayaran': tanggalPembayaran,
      'jumlah_pembayaran': jumlahPembayaran,
      'bukti_pembayaran': buktiPembayaran,
      // Exclude
      'pemilik': {'username': namaPemilik},
      'hewan': {'nama_hewan': namaHewan},
      'dokter': {'nama_dokter': namaDokter},
      'appointment': {'catatan': catatan},
      'rekammedis': {'keluhan': keluhan},
      'obat': {'nama_obat': namaObat},
      'resep': {'jumlah_obat': jumlahObat},
    };
  }
}
