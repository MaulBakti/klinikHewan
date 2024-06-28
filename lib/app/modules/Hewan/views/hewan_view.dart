import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Hewan/controllers/hewan_controller.dart';
import 'package:klinik_hewan/app/modules/Hewan/models/hewan.dart';

class HewanView extends StatelessWidget {
  final String role;
  final String token;
  final HewanController controller = Get.put(HewanController());

  HewanView({required this.role, required this.token}) {
    controller.getToken();
    controller.getDataHewan();
    controller.getRole();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Hewan'),
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
        } else if (controller.hewanList.isEmpty) {
          return _buildEmptyState(context);
        } else {
          return _buildHewanList(context);
        }
      }),
      floatingActionButton: role == 'admin' || role == 'pegawai'
          ? FloatingActionButton(
              onPressed: () {
                _addHewan(context);
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
          Text('Tidak ada data hewan'),
          if (role == 'admin' || role == 'pegawai')
            ElevatedButton(
              onPressed: () {
                _addHewan(context);
              },
              child: Text('Tambah Hewan'),
            ),
        ],
      ),
    );
  }

  Widget _buildHewanList(BuildContext context) {
    return ListView.builder(
      itemCount: controller.hewanList.length,
      itemBuilder: (context, index) {
        final hewan = controller.hewanList[index];
        return Card(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(hewan.namaHewan ?? ''),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Jenis: ${hewan.jenisHewan ?? ''}'),
                Text('Umur: ${hewan.umur ?? ''} tahun'),
                Text('Berat: ${hewan.berat ?? ''} kg'),
                Text('Jenis Kelamin: ${hewan.jenisKelamin ?? ''}'),
              ],
            ),
            trailing: Wrap(
              spacing: 8.0,
              children: [
                if (role == 'admin' || role == 'pegawai')
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _editHewan(context, hewan);
                    },
                  ),
                if (role == 'admin')
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _confirmDelete(context, hewan.idHewan ?? 0);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addHewan(BuildContext context) {
    final TextEditingController namaController = TextEditingController();
    final TextEditingController jenisController = TextEditingController();
    final TextEditingController umurController = TextEditingController();
    final TextEditingController beratController = TextEditingController();
    final TextEditingController jenisKelaminController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Hewan'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: namaController,
                  decoration: InputDecoration(
                    labelText: 'Nama Hewan',
                  ),
                ),
                TextField(
                  controller: jenisController,
                  decoration: InputDecoration(
                    labelText: 'Jenis Hewan',
                  ),
                ),
                TextField(
                  controller: umurController,
                  decoration: InputDecoration(
                    labelText: 'Umur',
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: beratController,
                  decoration: InputDecoration(
                    labelText: 'Berat (kg)',
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: jenisKelaminController,
                  decoration: InputDecoration(
                    labelText: 'Jenis Kelamin',
                  ),
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
            ),
            ElevatedButton(
              onPressed: () {
                _validateAndSaveHewan(
                  context,
                  namaController,
                  jenisController,
                  umurController,
                  beratController,
                  jenisKelaminController,
                );
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _validateAndSaveHewan(
    BuildContext context,
    TextEditingController namaController,
    TextEditingController jenisController,
    TextEditingController umurController,
    TextEditingController beratController,
    TextEditingController jenisKelaminController,
  ) {
    if (namaController.text.isNotEmpty &&
        jenisController.text.isNotEmpty &&
        umurController.text.isNotEmpty &&
        beratController.text.isNotEmpty &&
        jenisKelaminController.text.isNotEmpty) {
      final newHewan = Hewan(
        idHewan: 0, // or any default value if it's a new entry
        idPemilik: 'some_id', // Provide the correct idPemilik
        namaHewan: namaController.text,
        jenisHewan: jenisController.text,
        umur: int.tryParse(umurController.text) ?? 0,
        berat: double.tryParse(beratController.text) ?? 0.0,
        jenisKelamin: jenisKelaminController.text,
      );
      Get.find<HewanController>().postDataHewan(newHewan).then((_) {
        // Reset form fields after successful submission
        namaController.clear();
        jenisController.clear();
        umurController.clear();
        beratController.clear();
        jenisKelaminController.clear();

        Get.back(); // Close dialog after successful submission
      }).catchError((error) {
        // Handle specific errors or show generic error message
        Get.snackbar('Error', 'Failed to create hewan: $error');
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Semua field harus diisi'),
        ),
      );
    }
  }

  void _validateAndEditHewan(
    BuildContext context,
    Hewan hewan,
    TextEditingController namaController,
    TextEditingController jenisController,
    TextEditingController umurController,
    TextEditingController beratController,
    TextEditingController jenisKelaminController,
  ) {
    if (namaController.text.isNotEmpty &&
        jenisController.text.isNotEmpty &&
        umurController.text.isNotEmpty &&
        beratController.text.isNotEmpty &&
        jenisKelaminController.text.isNotEmpty) {
      final updatedHewan = Hewan(
        idHewan: hewan.idHewan,
        idPemilik: hewan.idPemilik, // ensure this is provided as well
        namaHewan: namaController.text,
        jenisHewan: jenisController.text,
        umur: int.tryParse(umurController.text) ?? 0,
        berat: double.tryParse(beratController.text) ?? 0.0,
        jenisKelamin: jenisKelaminController.text,
      );
      Get.find<HewanController>().updateHewan(updatedHewan).then((_) {
        Navigator.of(context).pop();
      }).catchError((error) {
        // Handle specific errors or show generic error message
        Get.snackbar('Error', 'Failed to update hewan: $error');
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Semua field harus diisi'),
        ),
      );
    }
  }

  void _confirmDelete(BuildContext context, int idHewan) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus hewan ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.find<HewanController>().deleteHewan(idHewan).then((_) {
                  Navigator.of(context).pop();
                }).catchError((error) {
                  // Handle specific errors or show generic error message
                  Get.snackbar('Error', 'Failed to delete hewan: $error');
                });
              },
              child: Text('Hapus'),
            ),
          ],
        );
      },
    );
  }
}
