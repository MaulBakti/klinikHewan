import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Appointment/model/appointment.dart';
import 'package:klinik_hewan/app/modules/Doctor/model/doctor.dart';
import 'package:klinik_hewan/app/modules/Hewan/models/hewan.dart';
import 'package:klinik_hewan/app/modules/Obat/model/obat.dart';
import 'package:klinik_hewan/app/modules/Pemilik/models/pemilik.dart';
import 'package:klinik_hewan/app/modules/RekamMedis/model/rekamMedis.dart';
import 'package:klinik_hewan/app/modules/Resep/model/resep.dart';
import '../controllers/pembayaran_controller.dart';
import '../model/pembayaran.dart';

class pembayaranView extends StatelessWidget {
  final pembayaranController controller = Get.put(pembayaranController());
  final String role;
  final String token;

  pembayaranView({required this.role, required this.token}) {
    controller.getToken();
    controller.getRole();
    controller.getDataPemilik(role);
    controller.getDataHewan(role);
    controller.getDataDoctor(role);
    controller.getDataAppoinment(role);
    controller.getDataRekamMedis(role);
    controller.getDataObat(role);
    controller.getDataResep(role);
    controller.getDataPembayaran(role, token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Pembayaran'),
        backgroundColor: Color(0xFFFFE4C4),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.errorMessage.value.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        } else if (controller.pembayaranList.isEmpty) {
          return _buildEmptyState(context);
        } else {
          return _buildPembayaranList(context);
        }
      }),
      floatingActionButton: Obx(() {
        final role = controller.role.value;
        // Define roles that should not have a FloatingActionButton
        const restrictedRoles = ['pemilik'];

        return Visibility(
          visible: !restrictedRoles.contains(role),
          child: FloatingActionButton(
            onPressed: () {
              print(role);
              _addPembayaran(context, token);
            },
            child: Icon(Icons.add),
          ),
        );
      }),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Tidak ada data pembayaran'),
        ],
      ),
    );
  }

  Widget _buildPembayaranList(BuildContext context) {
    return ListView.builder(
      itemCount: controller.pembayaranList.length,
      itemBuilder: (context, index) {
        final pembayaran = controller.pembayaranList[index];
        return Card(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
              title: Text("Nama Pemilik: ${pembayaran.namaPemilik}"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nama Hewan: ${pembayaran.namaHewan ?? ''}'),
                  Text('Nama Dokter: ${pembayaran.namaDokter ?? ''}'),
                  Text('Appointment: ${pembayaran.catatan ?? ''}'),
                  Text('Keluhan: ${pembayaran.keluhan ?? ''}'),
                  Text('Nama Obat: ${pembayaran.namaObat ?? ''}'),
                  Text('Jumlah Obat: ${pembayaran.jumlahObat ?? ''}'),
                  Text(
                      'Tanggal Pembayaran: ${pembayaran.tanggalPembayaran ?? ''}'),
                  Text(
                      'Jumlah Pembayaran: ${pembayaran.jumlahPembayaran ?? ''}'),
                  Text('Bukti Pembayaran: ${pembayaran.buktiPembayaran ?? ''}'),
                ],
              ),
              trailing: Obx(() {
                final role = controller.role.value;
                // Define roles that should not have a FloatingActionButton
                const restrictedRoles = ['pemilik'];

                return Visibility(
                    visible: !restrictedRoles.contains(role),
                    child: Wrap(
                      spacing: 8.0,
                      children: [
                        if (role == 'admin' || role == 'pegawai')
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _editPembayaran(context, pembayaran);
                            },
                          ),
                        if (role == 'admin')
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _confirmDelete(
                                  context, pembayaran.idPembayaran ?? 0);
                            },
                          ),
                      ],
                    ));
              })),
        );
      },
    );
  }

  void _addPembayaran(BuildContext context, String token) {
    Pemilik? selectedPemilik;
    Hewan? selectedHewan;
    Doctor? selectedDoctor;
    Appointment? selectedAppointment;
    rekamMedis? selectedRekamMedis;
    Obat? selectedObat;
    Resep? selectedResep;
    final TextEditingController jumlahPembayaranController =
        TextEditingController();
    final TextEditingController tanggalPembayaranController =
        TextEditingController();
    final TextEditingController buktiPembayaranController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Pembayaran'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() {
                  if (controller.isLoading.value) {
                    return CircularProgressIndicator();
                  } else if (controller.pemilikList.isEmpty) {
                    return Text('Tidak ada data pemilik');
                  } else {
                    return DropdownButtonFormField<Pemilik>(
                      value: selectedPemilik,
                      hint: Text('Pilih Pemilik'),
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      onChanged: (Pemilik? newValue) {
                        selectedPemilik = newValue;
                      },
                      items: controller.pemilikList.map((Pemilik pemilik) {
                        return DropdownMenuItem<Pemilik>(
                          value: pemilik,
                          child: Text(pemilik.namaPemilik ?? ''),
                        );
                      }).toList(),
                    );
                  }
                }),
                SizedBox(height: 10),
                Obx(() {
                  if (controller.isLoading.value) {
                    return CircularProgressIndicator();
                  } else if (controller.hewanList.isEmpty) {
                    return Text('Tidak ada data Hewan');
                  } else {
                    return DropdownButtonFormField<Hewan>(
                      value: selectedHewan,
                      hint: Text('Pilih Hewan'),
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      onChanged: (Hewan? newValue) {
                        selectedHewan = newValue;
                      },
                      items: controller.hewanList.map((Hewan hewan) {
                        return DropdownMenuItem<Hewan>(
                          value: hewan,
                          child: Text(hewan.namaHewan ?? ''),
                        );
                      }).toList(),
                    );
                  }
                }),
                SizedBox(
                  height: 10,
                ),
                Obx(() {
                  if (controller.isLoading.value) {
                    return CircularProgressIndicator();
                  } else if (controller.doctorList.isEmpty) {
                    return Text('Tidak ada data dokter');
                  } else {
                    return DropdownButtonFormField<Doctor>(
                      value: selectedDoctor,
                      hint: Text('Pilih Dokter'),
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      onChanged: (Doctor? newValue) {
                        selectedDoctor = newValue;
                      },
                      items: controller.doctorList.map((Doctor doctor) {
                        return DropdownMenuItem<Doctor>(
                          value: doctor,
                          child: Text(doctor.namaDokter ?? ''),
                        );
                      }).toList(),
                    );
                  }
                }),
                SizedBox(
                  height: 10,
                ),
                Obx(() {
                  if (controller.isLoading.value) {
                    return CircularProgressIndicator();
                  } else if (controller.appointmentList.isEmpty) {
                    return Text('Tidak ada data appointment');
                  } else {
                    return DropdownButtonFormField<Appointment>(
                      value: selectedAppointment,
                      hint: Text('Pilih Appointment'),
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      onChanged: (Appointment? newValue) {
                        selectedAppointment = newValue;
                      },
                      items: controller.appointmentList
                          .map((Appointment appointment) {
                        return DropdownMenuItem<Appointment>(
                          value: appointment,
                          child: Text(appointment.catatan ?? ''),
                        );
                      }).toList(),
                    );
                  }
                }),
                SizedBox(height: 10),
                Obx(() {
                  if (controller.isLoading.value) {
                    return CircularProgressIndicator();
                  } else if (controller.rekammedisList.isEmpty) {
                    return Text('Tidak ada data rekam medis');
                  } else {
                    return DropdownButtonFormField<rekamMedis>(
                      value: selectedRekamMedis,
                      hint: Text('Pilih Rekam Medis'),
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      onChanged: (rekamMedis? newValue) {
                        selectedRekamMedis = newValue;
                      },
                      items: controller.rekammedisList
                          .map((rekamMedis RekamMedis) {
                        return DropdownMenuItem<rekamMedis>(
                          value: RekamMedis,
                          child: Text(RekamMedis.keluhan ?? ''),
                        );
                      }).toList(),
                    );
                  }
                }),
                SizedBox(height: 10),
                Obx(() {
                  if (controller.isLoading.value) {
                    return CircularProgressIndicator();
                  } else if (controller.obatList.isEmpty) {
                    return Text('Tidak ada data obat');
                  } else {
                    return DropdownButtonFormField<Obat>(
                      value: selectedObat,
                      hint: Text('Pilih Obat'),
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      onChanged: (Obat? newValue) {
                        selectedObat = newValue;
                      },
                      items: controller.obatList.map((Obat obat) {
                        return DropdownMenuItem<Obat>(
                          value: obat,
                          child: Text(obat.namaObat ?? ''),
                        );
                      }).toList(),
                    );
                  }
                }),
                SizedBox(height: 10),
                Obx(() {
                  if (controller.isLoading.value) {
                    return CircularProgressIndicator();
                  } else if (controller.resepList.isEmpty) {
                    return Text('Tidak ada data resep');
                  } else {
                    return DropdownButtonFormField<Resep>(
                      value: selectedResep,
                      hint: Text('Pilih Resep'),
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      onChanged: (Resep? newValue) {
                        selectedResep = newValue;
                      },
                      items: controller.resepList.map((Resep resep) {
                        return DropdownMenuItem<Resep>(
                          value: resep,
                          child: Text('Resep ${resep.idResep}'),
                        );
                      }).toList(),
                    );
                  }
                }),
                SizedBox(height: 10),
                TextField(
                  controller: jumlahPembayaranController,
                  decoration: InputDecoration(
                      labelText: 'Jumlah Pembayaran',
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                      tanggalPembayaranController.text = formattedDate;
                    }
                  },
                  child: AbsorbPointer(
                    child: TextField(
                      controller: tanggalPembayaranController,
                      decoration: InputDecoration(
                        labelText: 'Tanggal Pembayaran',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: buktiPembayaranController,
                  decoration: InputDecoration(
                      labelText: 'Bukti Pembayaran',
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Batal'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                )),
            ElevatedButton(
              onPressed: () {
                _validateAndSavePembayaran(
                  context,
                  token,
                  selectedPemilik,
                  selectedHewan,
                  selectedDoctor,
                  selectedAppointment,
                  selectedRekamMedis,
                  selectedObat,
                  selectedResep,
                  jumlahPembayaranController,
                  tanggalPembayaranController,
                  buktiPembayaranController,
                );
                Get.back();
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _validateAndSavePembayaran(
    BuildContext context,
    String token,
    Pemilik? selectedPemilik,
    Hewan? selectedHewan,
    Doctor? selectedDoctor,
    Appointment? selectedAppointment,
    rekamMedis? selectedRekamMedis,
    Obat? selectedObat,
    Resep? selectedResep,
    TextEditingController jumlahPembayaranController,
    TextEditingController tanggalPembayaranController,
    TextEditingController buktiPembayaranController,
  ) {
    if (selectedPemilik != null &&
        selectedHewan != null &&
        selectedDoctor != null &&
        selectedAppointment != null &&
        selectedRekamMedis != null &&
        selectedObat != null &&
        selectedResep != null &&
        jumlahPembayaranController.text.isNotEmpty &&
        tanggalPembayaranController.text.isNotEmpty &&
        buktiPembayaranController.text.isNotEmpty) {
      final newPembayaran = Pembayaran(
        idPembayaran: 0,
        idRekamMedis: selectedRekamMedis.idRekamMedis ?? 0,
        keluhan: selectedRekamMedis.keluhan ?? '',
        idPemilik: selectedPemilik.idPemilik ?? 0,
        namaPemilik: selectedPemilik.namaPemilik ?? '',
        idHewan: selectedHewan.idHewan ?? 0,
        namaHewan: selectedHewan.namaHewan ?? '',
        idDokter: selectedDoctor.idDokter ?? 0,
        namaDokter: selectedDoctor.namaDokter ?? '',
        idAppointment: selectedAppointment.idAppointment ?? 0,
        catatan: selectedAppointment.catatan ?? '',
        idObat: selectedObat.idObat ?? 0,
        namaObat: selectedObat.namaObat ?? '',
        idResep: selectedResep.idResep ?? 0,
        jumlahObat: selectedResep.jumlahObat ?? 0,
        tanggalPembayaran: tanggalPembayaranController.text,
        jumlahPembayaran: jumlahPembayaranController.text,
        buktiPembayaran: buktiPembayaranController.text,
      );

      Get.find<pembayaranController>()
          .CreatePembayaran(role, token, newPembayaran)
          .then((_) {
        tanggalPembayaranController.clear();
        jumlahPembayaranController.clear();
        buktiPembayaranController.clear();
        Navigator.of(context).pop();
      }).catchError((error) {
        Get.defaultDialog(
          title: 'Error',
          middleText: 'Failed to create pembayaran: $error',
        );
      });
    } else {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Semua field harus diisi',
      );
    }
  }

  void _editPembayaran(BuildContext context, Pembayaran pembayaran) {
    Pemilik? selectedPemilik = controller.pemilikList.firstWhere(
      (pemilik) => pemilik.idPemilik == pemilik.idPemilik,
    );
    Hewan? selectedHewan = controller.hewanList.firstWhere(
      (hewan) => hewan.idHewan == hewan.idHewan,
    );
    Doctor? selectedDoctor = controller.doctorList.firstWhere(
      (doctor) => doctor.idDokter == doctor.idDokter,
    );
    Appointment? selectedAppointment = controller.appointmentList.firstWhere(
      (Appointment) => Appointment.idAppointment == Appointment.idAppointment,
    );
    rekamMedis? selectedRekamMedis = controller.rekammedisList.firstWhere(
      (rekamMedis) => rekamMedis.idRekamMedis == rekamMedis.idRekamMedis,
    );
    Obat? selectedObat = controller.obatList.firstWhere(
      (obat) => obat.idObat == obat.idObat,
    );
    Resep? selectedResep = controller.resepList.firstWhere(
      (Resep) => Resep.idResep == Resep.idResep,
    );
    final TextEditingController tanggalPembayaranController =
        TextEditingController(text: pembayaran.tanggalPembayaran);
    final TextEditingController jumlahPembayaranController =
        TextEditingController(text: pembayaran.jumlahPembayaran.toString());
    final TextEditingController buktiPembayaranController =
        TextEditingController(text: pembayaran.buktiPembayaran);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Pembayaran'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() {
                  if (controller.isLoading.value) {
                    return CircularProgressIndicator();
                  } else if (controller.pemilikList.isEmpty) {
                    return Text('Tidak ada data pemilik');
                  } else {
                    return DropdownButtonFormField<Pemilik>(
                      value: selectedPemilik,
                      hint: Text('Pilih Pemilik'),
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      onChanged: (Pemilik? newValue) {
                        selectedPemilik = newValue;
                      },
                      items: controller.pemilikList.map((Pemilik pemilik) {
                        return DropdownMenuItem<Pemilik>(
                          value: pemilik,
                          child: Text(pemilik.namaPemilik ?? ''),
                        );
                      }).toList(),
                    );
                  }
                }),
                SizedBox(height: 10),
                Obx(() {
                  if (controller.isLoading.value) {
                    return CircularProgressIndicator();
                  } else if (controller.hewanList.isEmpty) {
                    return Text('Tidak ada data Hewan');
                  } else {
                    return DropdownButtonFormField<Hewan>(
                      value: selectedHewan,
                      hint: Text('Pilih Hewan'),
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      onChanged: (Hewan? newValue) {
                        selectedHewan = newValue;
                      },
                      items: controller.hewanList.map((Hewan hewan) {
                        return DropdownMenuItem<Hewan>(
                          value: hewan,
                          child: Text(hewan.namaHewan ?? ''),
                        );
                      }).toList(),
                    );
                  }
                }),
                SizedBox(
                  height: 10,
                ),
                Obx(() {
                  if (controller.isLoading.value) {
                    return CircularProgressIndicator();
                  } else if (controller.doctorList.isEmpty) {
                    return Text('Tidak ada data dokter');
                  } else {
                    return DropdownButtonFormField<Doctor>(
                      value: selectedDoctor,
                      hint: Text('Pilih Dokter'),
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      onChanged: (Doctor? newValue) {
                        selectedDoctor = newValue;
                      },
                      items: controller.doctorList.map((Doctor doctor) {
                        return DropdownMenuItem<Doctor>(
                          value: doctor,
                          child: Text(doctor.namaDokter ?? ''),
                        );
                      }).toList(),
                    );
                  }
                }),
                SizedBox(
                  height: 10,
                ),
                Obx(() {
                  if (controller.isLoading.value) {
                    return CircularProgressIndicator();
                  } else if (controller.appointmentList.isEmpty) {
                    return Text('Tidak ada data appointment');
                  } else {
                    return DropdownButtonFormField<Appointment>(
                      value: selectedAppointment,
                      hint: Text('Pilih Appointment'),
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      onChanged: (Appointment? newValue) {
                        selectedAppointment = newValue;
                      },
                      items: controller.appointmentList
                          .map((Appointment appointment) {
                        return DropdownMenuItem<Appointment>(
                          value: appointment,
                          child: Text(appointment.catatan ?? ''),
                        );
                      }).toList(),
                    );
                  }
                }),
                SizedBox(height: 10),
                Obx(() {
                  if (controller.isLoading.value) {
                    return CircularProgressIndicator();
                  } else if (controller.rekammedisList.isEmpty) {
                    return Text('Tidak ada data rekam medis');
                  } else {
                    return DropdownButtonFormField<rekamMedis>(
                      value: selectedRekamMedis,
                      hint: Text('Pilih Rekam Medis'),
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      onChanged: (rekamMedis? newValue) {
                        selectedRekamMedis = newValue;
                      },
                      items: controller.rekammedisList
                          .map((rekamMedis RekamMedis) {
                        return DropdownMenuItem<rekamMedis>(
                          value: RekamMedis,
                          child: Text(RekamMedis.keluhan ?? ''),
                        );
                      }).toList(),
                    );
                  }
                }),
                SizedBox(height: 10),
                Obx(() {
                  if (controller.isLoading.value) {
                    return CircularProgressIndicator();
                  } else if (controller.obatList.isEmpty) {
                    return Text('Tidak ada data obat');
                  } else {
                    return DropdownButtonFormField<Obat>(
                      value: selectedObat,
                      hint: Text('Pilih Obat'),
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      onChanged: (Obat? newValue) {
                        selectedObat = newValue;
                      },
                      items: controller.obatList.map((Obat obat) {
                        return DropdownMenuItem<Obat>(
                          value: obat,
                          child: Text(obat.namaObat ?? ''),
                        );
                      }).toList(),
                    );
                  }
                }),
                SizedBox(height: 10),
                Obx(() {
                  if (controller.isLoading.value) {
                    return CircularProgressIndicator();
                  } else if (controller.resepList.isEmpty) {
                    return Text('Tidak ada data resep');
                  } else {
                    return DropdownButtonFormField<Resep>(
                      value: selectedResep,
                      hint: Text('Pilih Resep'),
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      onChanged: (Resep? newValue) {
                        selectedResep = newValue;
                      },
                      items: controller.resepList.map((Resep resep) {
                        return DropdownMenuItem<Resep>(
                          value: resep,
                          child: Text('Resep ${resep.idResep}'),
                        );
                      }).toList(),
                    );
                  }
                }),
                SizedBox(height: 10),
                TextField(
                  controller: jumlahPembayaranController,
                  decoration: InputDecoration(
                      labelText: 'Jumlah Pembayaran',
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                      tanggalPembayaranController.text = formattedDate;
                    }
                  },
                  child: AbsorbPointer(
                    child: TextField(
                      controller: tanggalPembayaranController,
                      decoration: InputDecoration(
                        labelText: 'Tanggal Pembayaran',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: buktiPembayaranController,
                  decoration: InputDecoration(
                      labelText: 'Bukti Pembayaran',
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Batal'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                )),
            ElevatedButton(
                onPressed: () {
                  _validateAndEditPembayaran(
                    context,
                    pembayaran,
                    selectedPemilik,
                    selectedHewan,
                    selectedDoctor,
                    selectedAppointment,
                    selectedRekamMedis,
                    selectedObat,
                    selectedResep,
                    tanggalPembayaranController,
                    jumlahPembayaranController,
                    buktiPembayaranController,
                  );
                  Get.back();
                },
                child: Text('Simpan'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                )),
          ],
        );
      },
    );
  }

  void _validateAndEditPembayaran(
    BuildContext context,
    Pembayaran pembayaran,
    Pemilik? selectedPemilik,
    Hewan? selectedHewan,
    Doctor? selectedDoctor,
    Appointment? selectedAppointment,
    rekamMedis? selectedRekamMedis,
    Obat? selectedObat,
    Resep? selectedResep,
    TextEditingController tanggalPembayaranController,
    TextEditingController jumlahPembayaranController,
    TextEditingController buktiPembayaranController,
  ) {
    if (selectedPemilik != null &&
        selectedHewan != null &&
        selectedDoctor != null &&
        selectedAppointment != null &&
        selectedRekamMedis != null &&
        selectedObat != null &&
        selectedResep != null &&
        jumlahPembayaranController.text.isNotEmpty &&
        tanggalPembayaranController.text.isNotEmpty &&
        buktiPembayaranController.text.isNotEmpty) {
      final updatedPembayaran = Pembayaran(
        idPembayaran: pembayaran.idPembayaran,
        idRekamMedis: selectedRekamMedis.idRekamMedis ?? 0,
        keluhan: selectedRekamMedis.keluhan ?? '',
        idPemilik: selectedPemilik.idPemilik ?? 0,
        namaPemilik: selectedPemilik.namaPemilik ?? '',
        idHewan: selectedHewan.idHewan ?? 0,
        namaHewan: selectedHewan.namaHewan ?? '',
        idDokter: selectedDoctor.idDokter ?? 0,
        namaDokter: selectedDoctor.namaDokter ?? '',
        idAppointment: selectedAppointment.idAppointment ?? 0,
        catatan: selectedAppointment.catatan ?? '',
        idObat: selectedObat.idObat ?? 0,
        namaObat: selectedObat.namaObat ?? '',
        idResep: selectedResep.jumlahObat ?? 0,
        jumlahObat: selectedResep.jumlahObat ?? 0,
        tanggalPembayaran: tanggalPembayaranController.text,
        jumlahPembayaran: jumlahPembayaranController.text,
        buktiPembayaran: buktiPembayaranController.text,
      );
      print(updatedPembayaran);
      Get.find<pembayaranController>()
          .updatePembayaran(role, token, updatedPembayaran)
          .then((_) {
        Navigator.of(context).pop();
      }).catchError((error) {
        Get.defaultDialog(
          title: 'Error',
          middleText: 'Failed to update pembayaran: $error',
        );
      });
    } else {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Semua field harus diisi',
      );
    }
  }

  void _confirmDelete(BuildContext context, int idPembayaran) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus pembayaran ini?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Batal'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                )),
            ElevatedButton(
                onPressed: () {
                  Get.find<pembayaranController>()
                      .deletePembayaran(role, idPembayaran, token)
                      .then((_) {
                    Navigator.of(context).pop();
                  }).catchError((error) {
                    Get.defaultDialog(
                      title: 'Error',
                      middleText: 'Failed to delete pembayaran: $error',
                    );
                  });
                },
                child: Text('Hapus'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                )),
          ],
        );
      },
    );
  }
}
