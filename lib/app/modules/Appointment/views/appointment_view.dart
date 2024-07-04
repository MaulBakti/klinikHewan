import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/appointment_controller.dart';
import '../model/appointment.dart';

class AppointmentView extends StatelessWidget {
  final String role;
  final String token;
  final AppointmentController controller = Get.put(AppointmentController());

  AppointmentView({required this.role, required this.token}) {
    controller.getToken();
    controller.getRole();
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
                Text('Tanggal: ${appointment.tglAppointment ?? ''} tahun'),
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
                      _confirmDelete(context, appointment.idDokter ?? 0);
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
    final TextEditingController idHewanController = TextEditingController();
    final TextEditingController idDokterController = TextEditingController();
    final TextEditingController TglController = TextEditingController();
    final TextEditingController CatatanController = TextEditingController();
    final TextEditingController namaHewanController = TextEditingController();
    final TextEditingController namaDokterController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Appointment'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: idHewanController,
                  decoration: InputDecoration(
                      labelText: 'ID Hewan', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: idDokterController,
                  decoration: InputDecoration(
                      labelText: 'ID Dokter', border: OutlineInputBorder()),
                ),
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
                TextField(
                  controller: namaHewanController,
                  decoration: InputDecoration(
                      labelText: 'Nama Hewan', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: namaDokterController,
                  decoration: InputDecoration(
                      labelText: 'Nama Dokter', border: OutlineInputBorder()),
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
                      idHewanController,
                      idDokterController,
                      TglController,
                      CatatanController,
                      namaHewanController,
                      namaDokterController);
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
      TextEditingController idHewanController,
      TextEditingController idDokterController,
      TextEditingController TglController,
      TextEditingController CatatanController,
      TextEditingController namaHewanController,
      TextEditingController namaDokterController) {
    if (idHewanController.text.isNotEmpty &&
        idDokterController.text.isNotEmpty &&
        TglController.text.isNotEmpty &&
        CatatanController.text.isNotEmpty &&
        namaHewanController.text.isNotEmpty &&
        namaDokterController.text.isNotEmpty) {
      final newAppointment = Appointment(
        idAppointment: 0,
        idHewan: int.tryParse(idHewanController.text) ?? 0,
        idDokter: int.tryParse(idDokterController.text) ?? 0,
        tglAppointment: TglController.text,
        catatan: CatatanController.text,
        namaHewan: namaHewanController.text,
        namaDokter: namaDokterController.text,
      );
      Get.find<AppointmentController>()
          .postDataAppointment(newAppointment)
          .then((_) {
        // Reset form fields after successful submission
        idHewanController.clear();
        idDokterController.clear();
        TglController.clear();
        CatatanController.clear();
        namaHewanController.clear();
        namaDokterController.clear();

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
    final TextEditingController idHewanController =
        TextEditingController(text: appointment.idHewan.toString());
    final TextEditingController idDokterController =
        TextEditingController(text: appointment.idDokter.toString());
    final TextEditingController TglController =
        TextEditingController(text: appointment.tglAppointment);
    final TextEditingController CatatanController =
        TextEditingController(text: appointment.catatan);
    final TextEditingController namaHewanController =
        TextEditingController(text: appointment.namaHewan);
    final TextEditingController namaDokterController =
        TextEditingController(text: appointment.namaDokter);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Appointment'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: idHewanController,
                  decoration: InputDecoration(
                      labelText: 'ID Hewan', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: idDokterController,
                  decoration: InputDecoration(
                      labelText: 'ID Dokter', border: OutlineInputBorder()),
                ),
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
                TextField(
                  controller: namaHewanController,
                  decoration: InputDecoration(
                      labelText: 'Nama Hewan', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: namaDokterController,
                  decoration: InputDecoration(
                      labelText: 'Nama Dokter', border: OutlineInputBorder()),
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
                      idHewanController,
                      idDokterController,
                      TglController,
                      CatatanController,
                      namaHewanController,
                      namaDokterController);
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
    TextEditingController idHewanController,
    TextEditingController idDokterController,
    TextEditingController TglController,
    TextEditingController CatatanController,
    TextEditingController namaHewanController,
    TextEditingController namaDokterController,
  ) {
    if (idHewanController.text.isNotEmpty &&
        idDokterController.text.isNotEmpty &&
        TglController.text.isNotEmpty &&
        CatatanController.text.isNotEmpty &&
        namaHewanController.text.isNotEmpty &&
        namaDokterController.text.isNotEmpty) {
      final updatedAppointment = Appointment(
        idAppointment: appointment.idAppointment,
        idHewan: int.tryParse(idHewanController.text) ?? 0,
        idDokter: int.tryParse(idDokterController.text) ?? 0,
        tglAppointment: TglController.text,
        catatan: CatatanController.text,
        namaHewan: namaHewanController.text,
        namaDokter: namaDokterController.text,
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
