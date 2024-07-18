import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Appointment/controllers/appointment_controller.dart';
import '../model/appointment.dart';
import 'package:klinik_hewan/app/modules/Pemilik/models/pemilik.dart';
import 'package:klinik_hewan/app/modules/Hewan/models/hewan.dart';
import 'package:klinik_hewan/app/modules/Doctor/model/doctor.dart';
import 'package:klinik_hewan/app/modules/Appointment/model/appointment.dart';

class AppointmentView extends StatelessWidget {
  final AppointmentController controller = Get.put(AppointmentController());
  final String role;
  final String token;

  AppointmentView({required this.role, required this.token}) {
    controller.getToken();
    controller.getRole();
    controller.getDataPemilik(role);
    controller.getDataHewan(role);
    controller.getDataDoctor(role);
    controller.getDataAppointment(role);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Appointment'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Text('Error: ${controller.errorMessage.value}'),
          );
        } else if (controller.appointmentList.isEmpty) {
          return _buildEmptyState(context);
        } else {
          return _buildAppointmentList(context);
        }
      }),
      floatingActionButton: role == 'admin' || role == 'pegawai'
          ? FloatingActionButton(
              onPressed: () {
                print(role);
                _addAppointment(context, token);
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Tidak ada data appointment'),
        ],
      ),
    );
  }

  Widget _buildAppointmentList(BuildContext context) {
    return ListView.builder(
      itemCount: controller.appointmentList.length,
      itemBuilder: (context, index) {
        final appointment = controller.appointmentList[index];
        return Card(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(appointment.namaHewan ?? ''),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nama Pemilik: ${appointment.namaPemilik ?? ''}'),
                Text('Nama Dokter: ${appointment.namaDokter ?? ''}'),
                Text('Tanggal: ${appointment.tglAppointment ?? ''}'),
                Text('Catatan: ${appointment.catatan ?? ''}'),
              ],
            ),
            trailing: Wrap(
              spacing: 8.0,
              children: [
                if (role == 'admin' || role == 'pegawai')
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _editAppointment(context, appointment);
                    },
                  ),
                if (role == 'admin')
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _confirmDelete(context, appointment.idAppointment ?? 0);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addAppointment(BuildContext context, String token) {
    Pemilik? selectedPemilik;
    Hewan? selectedHewan;
    Doctor? selectedDoctor;
    final TextEditingController TglController = TextEditingController();
    final TextEditingController CatatanController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Appointment'),
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
                TextField(
                  controller: TglController,
                  decoration: InputDecoration(
                      labelText: 'Tanggal', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: CatatanController,
                  decoration: InputDecoration(
                      labelText: 'Catatan', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
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
                  _validateAndSaveAppointment(
                      context,
                      token,
                      selectedPemilik,
                      selectedHewan,
                      selectedDoctor,
                      TglController,
                      CatatanController);
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

  void _validateAndSaveAppointment(
      BuildContext context,
      String token,
      Pemilik? selectedPemilik,
      Hewan? selectedHewan,
      Doctor? selectedDoctor,
      TextEditingController TglController,
      TextEditingController CatatanController) {
    if (selectedPemilik != null &&
        selectedHewan != null &&
        selectedDoctor != null &&
        TglController.text.isNotEmpty &&
        CatatanController.text.isNotEmpty) {
      final newAppointment = Appointment(
        idAppointment: 0,
        idPemilik: selectedPemilik.idPemilik ?? 0,
        namaPemilik: selectedPemilik.namaPemilik ?? '',
        idHewan: selectedHewan.idHewan ?? 0,
        namaHewan: selectedHewan.namaHewan ?? '',
        idDokter: selectedDoctor.idDokter ?? 0,
        namaDokter: selectedDoctor.namaDokter ?? '',
        tglAppointment: TglController.text,
        catatan: CatatanController.text,
      );
      Get.find<AppointmentController>()
          .postDataAppointment(newAppointment)
          .then((_) {
        // Reset form fields after successful submission
        TglController.clear();
        CatatanController.clear();

        // Get.back(); // Close dialog after successful submission
      }).catchError((error) {
        // Handle specific errors or show generic error message
        Get.defaultDialog(
          title: 'Error',
          middleText: 'Failed to create appointment: $error',
        );
      });
    } else {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Semua field harus diisi',
      );
    }
  }

  void _editAppointment(BuildContext context, Appointment appointment) {
    Pemilik? selectedPemilik = controller.pemilikList.firstWhere(
      (pemilik) => pemilik.idPemilik == pemilik.idPemilik,
    );
    Hewan? selectedHewan = controller.hewanList.firstWhere(
      (hewan) => hewan.idHewan == hewan.idHewan,
    );
    Doctor? selectedDoctor = controller.doctorList.firstWhere(
      (doctor) => doctor.idDokter == doctor.idDokter,
    );
    final TextEditingController TglController =
        TextEditingController(text: appointment.tglAppointment);
    final TextEditingController CatatanController =
        TextEditingController(text: appointment.catatan);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Appointment'),
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
                TextField(
                  controller: TglController,
                  decoration: InputDecoration(
                      labelText: 'Tanggal', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: CatatanController,
                  decoration: InputDecoration(
                      labelText: 'Catatan', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
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
                  _validateAndEditAppointment(
                      context,
                      appointment,
                      selectedPemilik,
                      selectedHewan,
                      selectedDoctor,
                      TglController,
                      CatatanController);
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

  void _validateAndEditAppointment(
    BuildContext context,
    Appointment appointment,
    Pemilik? selectedPemilik,
    Hewan? selectedHewan,
    Doctor? selectedDoctor,
    TextEditingController TglController,
    TextEditingController CatatanController,
  ) {
    if (selectedPemilik != null &&
        selectedHewan != null &&
        selectedDoctor != null &&
        TglController.text.isNotEmpty &&
        CatatanController.text.isNotEmpty) {
      final updatedAppointment = Appointment(
        idAppointment: appointment.idAppointment,
        idPemilik: selectedPemilik.idPemilik ?? 0,
        namaPemilik: selectedPemilik.namaPemilik ?? '',
        idHewan: selectedHewan.idHewan ?? 0,
        namaHewan: selectedHewan.namaHewan ?? '',
        idDokter: selectedDoctor.idDokter ?? 0,
        namaDokter: selectedDoctor.namaDokter ?? '',
        tglAppointment: TglController.text,
        catatan: CatatanController.text,
      );
      Get.find<AppointmentController>().updateAppointment(updatedAppointment);
      Navigator.of(context).pop();
    } else {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Semua field harus diisi',
      );
    }
  }

  void _confirmDelete(BuildContext context, int idAppointment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus appointment ini?'),
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
                  // Call deleteappointment method from your controller
                  // Example assuming deleteappointment exists in your appointmentController
                  Get.find<AppointmentController>()
                      .deleteAppointment(idAppointment);
                  Navigator.of(context).pop();
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
