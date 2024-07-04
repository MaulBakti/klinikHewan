import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pemilik_controller.dart';
import '../models/pemilik.dart';

class PemilikView extends StatelessWidget {
  final String role;
  final String token;
  final PemilikController controller = Get.put(PemilikController());

  PemilikView({required this.role, required this.token}) {
    controller.getToken();
    controller.getRole();
    controller.getDataPemilik(role);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Pemilik'),
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
        } else if (controller.pemilikList.isEmpty) {
          return _buildEmptyState(context);
        } else {
          return _buildPemilikList(context);
        }
      }),
      floatingActionButton: role == 'admin' || role == 'pegawai'
          ? FloatingActionButton(
              onPressed: () {
                print(role);
                _addPemilik(context, token);
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
          Text('Tidak ada data pemilik'),
        ],
      ),
    );
  }

  Widget _buildPemilikList(BuildContext context) {
    return ListView.builder(
      itemCount: controller.pemilikList.length,
      itemBuilder: (context, index) {
        final pemilik = controller.pemilikList[index];
        return Card(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(pemilik.namaPemilik ?? ''),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Alamat: ${pemilik.alamat ?? ''}'),
                Text('No Telp: ${pemilik.noTelp ?? ''} tahun'),
              ],
            ),
            trailing: Wrap(
              spacing: 8.0,
              children: [
                if (role == 'admin' || role == 'pegawai')
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _editPemilik(context, pemilik);
                    },
                  ),
                if (role == 'admin')
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _confirmDelete(context, pemilik.idPemilik ?? 0);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addPemilik(BuildContext context, String token) {
    final TextEditingController namaController = TextEditingController();
    final TextEditingController alamatController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController noTelpController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Pemilik'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: namaController,
                  decoration: InputDecoration(
                      labelText: 'Nama Pemilik', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: alamatController,
                  decoration: InputDecoration(
                      labelText: 'Alamat', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      labelText: 'Password', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: noTelpController,
                  decoration: InputDecoration(
                      labelText: 'No Telp', border: OutlineInputBorder()),
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
                  _validateAndSavePemilik(context, token, namaController,
                      alamatController, noTelpController, passwordController);
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

  void _validateAndSavePemilik(
    BuildContext context,
    String token,
    TextEditingController namaController,
    TextEditingController alamatController,
    TextEditingController noTelpController,
    TextEditingController passwordController,
  ) {
    if (namaController.text.isNotEmpty &&
        alamatController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        noTelpController.text.isNotEmpty) {
      final newPemilik = Pemilik(
        idPemilik: 0,
        namaPemilik: namaController.text,
        password: passwordController.text,
        alamat: alamatController.text,
        noTelp: noTelpController.text,
      );
      Get.find<PemilikController>().postDataPemilik(newPemilik).then((_) {
        // Reset form fields after successful submission
        namaController.clear();

        passwordController.clear();
        alamatController.clear();
        noTelpController.clear();

        // Get.back(); // Close dialog after successful submission
      }).catchError((error) {
        // Handle specific errors or show generic error message
        Get.defaultDialog(
          title: 'Error',
          middleText: 'Failed to create pemilik: $error',
        );
      });
    } else {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Semua field harus diisi',
      );
    }
  }

  void _editPemilik(BuildContext context, Pemilik pemilik) {
    final TextEditingController namaController =
        TextEditingController(text: pemilik.namaPemilik);
    final TextEditingController passwordController =
        TextEditingController(text: pemilik.password);

    final TextEditingController alamatController =
        TextEditingController(text: pemilik.alamat);
    final TextEditingController noTelpController =
        TextEditingController(text: pemilik.noTelp);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit pemilik'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: namaController,
                  decoration: InputDecoration(
                      labelText: 'Nama Pemilik', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: alamatController,
                  decoration: InputDecoration(
                      labelText: 'Alamat', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      labelText: 'Password', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: noTelpController,
                  decoration: InputDecoration(
                      labelText: 'No Telp', border: OutlineInputBorder()),
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
                  _validateAndEditPemilik(context, pemilik, namaController,
                      alamatController, noTelpController, passwordController);
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

  void _validateAndEditPemilik(
    BuildContext context,
    Pemilik pemilik,
    TextEditingController namaController,
    TextEditingController alamatController,
    TextEditingController noTelpController,
    TextEditingController passwordController,
  ) {
    if (namaController.text.isNotEmpty &&
        alamatController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        noTelpController.text.isNotEmpty) {
      final updatedPemilik = Pemilik(
        idPemilik: pemilik.idPemilik,
        namaPemilik: namaController.text,
        password: passwordController.text,
        alamat: alamatController.text,
        noTelp: noTelpController.text,
      );
      Get.find<PemilikController>().updatePemilik(updatedPemilik);
      Navigator.of(context).pop();
    } else {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Semua field harus diisi',
      );
    }
  }

  void _confirmDelete(BuildContext context, int idPemilik) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus pemilik ini?'),
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
                  // Call deletePemilik method from your controller
                  // Example assuming deletePemilik exists in your PemilikController
                  Get.find<PemilikController>().deletePemilik(idPemilik);
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

void _confirmDelete(BuildContext context, int idPemilik) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Konfirmasi Hapus'),
        content: Text('Apakah Anda yakin ingin menghapus pemilik ini?'),
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
                // Call deletePemilik method from your controller
                // Example assuming deletePemilik exists in your PemilikController
                Get.find<PemilikController>().deletePemilik(idPemilik);
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
