class Appointment {
  int idAppointment;
  int idHewan;
  int idDokter;
  String tglAppointment;
  String catatan;
  String namaHewan;
  String namaDokter;

  Appointment({
    required this.idAppointment,
    required this.idHewan,
    required this.idDokter,
    required this.tglAppointment,
    required this.catatan,
    required this.namaHewan,
    required this.namaDokter,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      idAppointment: json['id_hewan'] ?? 0,
      idHewan: json['id_hewan'] ?? 0,
      idDokter: json['id_dokter'] ?? 0,
      tglAppointment: json['tgl_appointment'] ?? '',
      catatan: json['catatan'] ?? '',
      namaHewan: json['hewan']['nama_hewan'] ?? '',
      namaDokter: json['doctor']['nama_dokter'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_appointment': idAppointment,
      'id_hewan': idHewan,
      'id_dokter': idDokter,
      'tgl_appointment': tglAppointment,
      'catatan': catatan,
      'nama_hewan': namaHewan,
      'nama_dokter': namaDokter,
    };
  }
}
