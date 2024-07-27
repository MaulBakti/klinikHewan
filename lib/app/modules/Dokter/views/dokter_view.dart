import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dokter_controller.dart';
import 'package:klinik_hewan/app/modules/Dokter/model/dokter.dart';

class DokterView extends StatelessWidget {
  final String role;
  final String token;
  final DokterController controller = Get.put(DokterController());

  DokterView({required this.role, required this.token}) {
    controller.getToken();
    controller.getRole();
    controller.getDataDokter(role);
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
        title: Text('Daftar Dokter'),
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
          } else if (controller.dokterList.isEmpty) {
            return _buildEmptyState(context);
          } else {
            return _buildDokterList(context);
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
              _addDokter(context, token);
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
          Text('Tidak ada data dokter'),
        ],
      ),
    );
  }

  Widget _buildDokterList(BuildContext context) {
    return ListView.builder(
      itemCount: controller.dokterList.length,
      itemBuilder: (context, index) {
        final dokter = controller.dokterList[index];
        return Card(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
              title: Text(dokter.namaDokter ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Spesialisasi: ${dokter.spesialisasi ?? ''}'),
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
                              _editDokter(context, dokter);
                            },
                          ),
                        if (role == 'admin')
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _confirmDelete(context, dokter.idDokter ?? 0);
                            },
                          ),
                      ],
                    ));
              })),
        );
      },
    );
  }

  void _addDokter(BuildContext context, String token) {
    final TextEditingController namaController = TextEditingController();
    final TextEditingController spesialisController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Dokter'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: namaController,
                  decoration: InputDecoration(
                      labelText: 'Nama Dokter', border: OutlineInputBorder()),
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
                  foregroundColor: Colors.white,
                  overlayColor: Color(0xFFffc26f),
                  backgroundColor: Color.fromRGBO(179, 110, 61, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                )),
            ElevatedButton(
                onPressed: () {
                  _validateAndSaveDokter(
                      context, token, namaController, spesialisController);
                  Get.back();
                },
                child: Text('Simpan'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  overlayColor: Color(0xFFffc26f),
                  backgroundColor: Color.fromRGBO(179, 110, 61, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                )),
          ],
        );
      },
    );
  }

  void _validateAndSaveDokter(
      BuildContext context,
      String token,
      TextEditingController namaController,
      TextEditingController spesialisController) {
    if (namaController.text.isNotEmpty && spesialisController.text.isNotEmpty) {
      final newDokter = Dokter(
        idDokter: 0,
        namaDokter: namaController.text,
        spesialisasi: spesialisController.text,
      );
      Get.find<DokterController>().postDataDokter(newDokter).then((_) {
        // Reset form fields after successful submission
        namaController.clear();
        spesialisController.clear();

        // Get.back(); // Close dialog after successful submission
      }).catchError((error) {
        // Handle specific errors or show generic error message
        Get.defaultDialog(
          title: 'Error',
          middleText: 'Failed to create dokter: $error',
        );
      });
    } else {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Semua field harus diisi',
      );
    }
  }

  void _editDokter(BuildContext context, Dokter dokter) {
    final TextEditingController namaController =
        TextEditingController(text: dokter.namaDokter);
    final TextEditingController spesialisController =
        TextEditingController(text: dokter.spesialisasi);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Dokter'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: namaController,
                  decoration: InputDecoration(
                      labelText: 'Nama Dokter', border: OutlineInputBorder()),
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
                  foregroundColor: Colors.white,
                  overlayColor: Color(0xFFffc26f),
                  backgroundColor: Color.fromRGBO(179, 110, 61, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                )),
            ElevatedButton(
                onPressed: () {
                  _validateAndEditDokter(
                      context, dokter, namaController, spesialisController);
                  // Get.back();
                },
                child: Text('Simpan'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  overlayColor: Color(0xFFffc26f),
                  backgroundColor: Color.fromRGBO(179, 110, 61, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                )),
          ],
        );
      },
    );
  }

  void _validateAndEditDokter(
    BuildContext context,
    Dokter dokter,
    TextEditingController namaController,
    TextEditingController spesialisController,
  ) {
    if (namaController.text.isNotEmpty && spesialisController.text.isNotEmpty) {
      final updateDokter = Dokter(
        idDokter: dokter.idDokter,
        namaDokter: namaController.text,
        spesialisasi: spesialisController.text,
      );
      Get.find<DokterController>().updateDokter(updateDokter);
      Navigator.of(context).pop();
    } else {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Semua field harus diisi',
      );
    }
  }

  void _confirmDelete(BuildContext context, int idDokter) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus dokter ini?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Batal'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  overlayColor: Color(0xFFffc26f),
                  backgroundColor: Color.fromRGBO(179, 110, 61, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                )),
            ElevatedButton(
                onPressed: () {
                  // Call deleteDoctor method from your controller
                  // Example assuming deleteDoctor exists in your DoctorController
                  Get.find<DokterController>().deleteDokter(idDokter);
                  Navigator.of(context).pop();
                },
                child: Text('Hapus'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  overlayColor: Color(0xFFffc26f),
                  backgroundColor: Color.fromRGBO(179, 110, 61, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                )),
          ],
        );
      },
    );
  }
}
