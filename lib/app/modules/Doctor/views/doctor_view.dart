import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/doctor_controller.dart';
import 'package:klinik_hewan/app/modules/Doctor/model/doctor.dart';

class DoctorView extends StatelessWidget {
  final String role;
  final String token;
  final DoctorController controller = Get.put(DoctorController());

  DoctorView({required this.role, required this.token}) {
    controller.getToken();
    controller.getRole();
    controller.getDataDoctor(role);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('Daftar Doctor'),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 24),
        backgroundColor: Color.fromRGBO(179, 110, 61, 1),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFFFFE4C4),
        padding: EdgeInsets.only(top: 20.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.errorMessage.value.isNotEmpty) {
            return Center(
              child: Text('Error: ${controller.errorMessage.value}'),
            );
          } else if (controller.doctorList.isEmpty) {
            return _buildEmptyState(context);
          } else {
            return _buildDoctorList(context);
          }
        }),
      ),
      floatingActionButton: Obx(() {
        final role = controller.role.value;
        // Define roles that should not have a FloatingActionButton
        const restrictedRoles = ['pemilik'];

        return Visibility(
          visible: !restrictedRoles.contains(role),
          child: FloatingActionButton(
            onPressed: () {
              print(role);
              _addDoctor(context, token);
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
          Text('Tidak ada data doctor'),
        ],
      ),
    );
  }

  Widget _buildDoctorList(BuildContext context) {
    return ListView.builder(
      itemCount: controller.doctorList.length,
      itemBuilder: (context, index) {
        final doctor = controller.doctorList[index];
        return Card(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
              title: Text(doctor.namaDokter ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Spesialisasi: ${doctor.spesialisasi ?? ''}'),
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
                              _editDoctor(context, doctor);
                            },
                          ),
                        if (role == 'admin')
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _confirmDelete(context, doctor.idDokter ?? 0);
                            },
                          ),
                      ],
                    ));
              })),
        );
      },
    );
  }

  void _addDoctor(BuildContext context, String token) {
    final TextEditingController namaController = TextEditingController();
    final TextEditingController spesialisController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Doctor'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: namaController,
                  decoration: InputDecoration(
                      labelText: 'Nama Doctor', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: spesialisController,
                  decoration: InputDecoration(
                      labelText: 'Spesialis', border: OutlineInputBorder()),
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
                  _validateAndSaveDoctor(
                      context, token, namaController, spesialisController);
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

  void _validateAndSaveDoctor(
      BuildContext context,
      String token,
      TextEditingController namaController,
      TextEditingController spesialisController) {
    if (namaController.text.isNotEmpty && spesialisController.text.isNotEmpty) {
      final newDoctor = Doctor(
        idDokter: 0,
        namaDokter: namaController.text,
        spesialisasi: spesialisController.text,
      );
      Get.find<DoctorController>().postDataDoctor(newDoctor).then((_) {
        // Reset form fields after successful submission
        namaController.clear();
        spesialisController.clear();

        // Get.back(); // Close dialog after successful submission
      }).catchError((error) {
        // Handle specific errors or show generic error message
        Get.defaultDialog(
          title: 'Error',
          middleText: 'Failed to create doctor: $error',
        );
      });
    } else {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Semua field harus diisi',
      );
    }
  }

  void _editDoctor(BuildContext context, Doctor doctor) {
    final TextEditingController namaController =
        TextEditingController(text: doctor.namaDokter);
    final TextEditingController spesialisController =
        TextEditingController(text: doctor.spesialisasi);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Doctor'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: namaController,
                  decoration: InputDecoration(
                      labelText: 'Nama Doctor', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: spesialisController,
                  decoration: InputDecoration(
                      labelText: 'Spesialisasi', border: OutlineInputBorder()),
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
                  _validateAndEditDoctor(
                      context, doctor, namaController, spesialisController);
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

  void _validateAndEditDoctor(
    BuildContext context,
    Doctor doctor,
    TextEditingController namaController,
    TextEditingController spesialisController,
  ) {
    if (namaController.text.isNotEmpty && spesialisController.text.isNotEmpty) {
      final updatedDoctor = Doctor(
        idDokter: doctor.idDokter,
        namaDokter: namaController.text,
        spesialisasi: spesialisController.text,
      );
      Get.find<DoctorController>().updateDoctor(updatedDoctor);
      Navigator.of(context).pop();
    } else {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Semua field harus diisi',
      );
    }
  }

  void _confirmDelete(BuildContext context, int idDoctor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus doctor ini?'),
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
                  // Call deleteDoctor method from your controller
                  // Example assuming deleteDoctor exists in your DoctorController
                  Get.find<DoctorController>().deleteDoctor(idDoctor);
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
