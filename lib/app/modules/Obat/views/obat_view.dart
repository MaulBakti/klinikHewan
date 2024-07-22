import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/obat_controller.dart';
import 'package:klinik_hewan/app/modules/Obat/model/obat.dart';

class ObatView extends StatelessWidget {
  final String role;
  final String token;
  final ObatController controller = Get.put(ObatController());

  ObatView({required this.role, required this.token}) {
    controller.getToken();
    controller.getRole();
    controller.getDataObat(role);
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
        title: Text('Daftar Obat'),
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
          } else if (controller.obatList.isEmpty) {
            return _buildEmptyState(context);
          } else {
            return _buildObatList(context);
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
              _addObat(context, token);
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
          Text('Tidak ada data obat'),
        ],
      ),
    );
  }

  Widget _buildObatList(BuildContext context) {
    return ListView.builder(
      itemCount: controller.obatList.length,
      itemBuilder: (context, index) {
        final obat = controller.obatList[index];
        return Container(
          child: Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
                title: Text(obat.namaObat ?? ''),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Keterangan: ${obat.keterangan ?? ''}'),
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
                                _editObat(context, obat);
                              },
                            ),
                          if (role == 'admin')
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _confirmDelete(context, obat.idObat ?? 0);
                              },
                            ),
                        ],
                      ));
                })),
          ),
        );
      },
    );
  }

  void _addObat(BuildContext context, String token) {
    final TextEditingController namaController = TextEditingController();
    final TextEditingController keteranganController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Obat'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: namaController,
                  decoration: InputDecoration(
                      labelText: 'Nama Obat', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: keteranganController,
                  decoration: InputDecoration(
                      labelText: 'Keterangan', border: OutlineInputBorder()),
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
                  _validateAndSaveObat(
                      context, token, namaController, keteranganController);
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

  void _validateAndSaveObat(
      BuildContext context,
      String token,
      TextEditingController namaController,
      TextEditingController keteranganController) {
    if (namaController.text.isNotEmpty &&
        keteranganController.text.isNotEmpty) {
      final newObat = Obat(
        idObat: 0,
        namaObat: namaController.text,
        keterangan: keteranganController.text,
      );
      Get.find<ObatController>().postDataObat(newObat).then((_) {
        // Reset form fields after successful submission
        namaController.clear();
        keteranganController.clear();

        // Get.back(); // Close dialog after successful submission
      }).catchError((error) {
        // Handle specific errors or show generic error message
        Get.defaultDialog(
          title: 'Error',
          middleText: 'Failed to create obat: $error',
        );
      });
    } else {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Semua field harus diisi',
      );
    }
  }

  void _editObat(BuildContext context, Obat obat) {
    final TextEditingController namaController =
        TextEditingController(text: obat.namaObat);
    final TextEditingController keteranganController =
        TextEditingController(text: obat.keterangan);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Obat'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: namaController,
                  decoration: InputDecoration(
                      labelText: 'Nama Obat', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: keteranganController,
                  decoration: InputDecoration(
                      labelText: 'Keterangan', border: OutlineInputBorder()),
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
                  _validateAndEditObat(
                      context, obat, namaController, keteranganController);
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

  void _validateAndEditObat(
      BuildContext context,
      Obat obat,
      TextEditingController namaController,
      TextEditingController keteranganController) {
    if (namaController.text.isNotEmpty &&
        keteranganController.text.isNotEmpty) {
      final updatedObat = Obat(
        idObat: obat.idObat,
        namaObat: namaController.text,
        keterangan: keteranganController.text,
      );
      Get.find<ObatController>().updateObat(updatedObat);
      Navigator.of(context).pop();
    } else {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Semua field harus diisi',
      );
    }
  }

  void _confirmDelete(BuildContext context, int idObat) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus obat ini?'),
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
                  // Call deleteobat method from your controller
                  // Example assuming deleteobat exists in your obatController
                  Get.find<ObatController>().deleteObat(idObat);
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
