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
    controller.getRole();
    controller.getDataHewan(role);
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
                print(role);
                _addHewan(context, token);
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
                _addHewan(context, token);
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

  void _addHewan(BuildContext context, String token) {
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
                    errorText: namaController.text.isEmpty
                        ? 'Field ini wajib diisi'
                        : null,
                  ),
                ),
                TextField(
                  controller: jenisController,
                  decoration: InputDecoration(
                    labelText: 'Jenis Hewan',
                    errorText: namaController.text.isEmpty
                        ? 'Field ini wajib diisi'
                        : null,
                  ),
                ),
                TextField(
                  controller: umurController,
                  decoration: InputDecoration(
                    labelText: 'Umur',
                    errorText: namaController.text.isEmpty
                        ? 'Field ini wajib diisi'
                        : null,
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: beratController,
                  decoration: InputDecoration(
                    labelText: 'Berat (kg)',
                    errorText: namaController.text.isEmpty
                        ? 'Field ini wajib diisi'
                        : null,
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: jenisKelaminController,
                  decoration: InputDecoration(
                    labelText: 'Jenis Kelamin',
                    errorText: namaController.text.isEmpty
                        ? 'Field ini wajib diisi'
                        : null,
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
                    token,
                    namaController,
                    jenisController,
                    umurController,
                    beratController,
                    jenisKelaminController);
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
      String token,
      TextEditingController namaController,
      TextEditingController jenisController,
      TextEditingController umurController,
      TextEditingController beratController,
      TextEditingController jenisKelaminController) {
    if (namaController.text.isNotEmpty &&
        jenisController.text.isNotEmpty &&
        umurController.text.isNotEmpty &&
        beratController.text.isNotEmpty &&
        jenisKelaminController.text.isNotEmpty) {
      final newHewan = Hewan(
        idHewan: 0,
        idPemilik: 0, // To be handled by backend, not needed in frontend
        namaHewan: namaController.text,
        jenisHewan: jenisController.text,
        umur: int.tryParse(umurController.text) ?? 0,
        berat: double.tryParse(beratController.text) ?? 0.0,
        jenisKelamin: jenisKelaminController.text,
      );
      Get.find<HewanController>().postDataHewan(token, newHewan).then((_) {
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

  void _editHewan(BuildContext context, Hewan hewan) {
    final TextEditingController namaController =
        TextEditingController(text: hewan.namaHewan);
    final TextEditingController jenisController =
        TextEditingController(text: hewan.jenisHewan);
    final TextEditingController umurController =
        TextEditingController(text: hewan.umur.toString());
    final TextEditingController beratController =
        TextEditingController(text: hewan.berat.toString());
    final TextEditingController jenisKelaminController =
        TextEditingController(text: hewan.jenisKelamin);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Hewan'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: namaController,
                  decoration: InputDecoration(labelText: 'Nama Hewan'),
                ),
                TextField(
                  controller: jenisController,
                  decoration: InputDecoration(labelText: 'Jenis Hewan'),
                ),
                TextField(
                  controller: umurController,
                  decoration: InputDecoration(labelText: 'Umur'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: beratController,
                  decoration: InputDecoration(labelText: 'Berat (kg)'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: jenisKelaminController,
                  decoration: InputDecoration(labelText: 'Jenis Kelamin'),
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
                _validateAndEditHewan(
                    context,
                    hewan,
                    namaController,
                    jenisController,
                    umurController,
                    beratController,
                    jenisKelaminController);
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _validateAndEditHewan(
      BuildContext context,
      Hewan hewan,
      TextEditingController namaController,
      TextEditingController jenisController,
      TextEditingController umurController,
      TextEditingController beratController,
      TextEditingController jenisKelaminController) {
    if (namaController.text.isNotEmpty &&
        jenisController.text.isNotEmpty &&
        umurController.text.isNotEmpty &&
        beratController.text.isNotEmpty &&
        jenisKelaminController.text.isNotEmpty) {
      final updatedHewan = Hewan(
        idHewan: hewan.idHewan,
        idPemilik: hewan
            .idPemilik, // Akan ditangani oleh backend, tidak diperlukan di frontend
        namaHewan: namaController.text,
        jenisHewan: jenisController.text,
        umur: int.tryParse(umurController.text) ?? 0,
        berat: double.tryParse(beratController.text) ?? 0.0,
        jenisKelamin: jenisKelaminController.text,
      );
      Get.find<HewanController>().updateHewan(role, updatedHewan);
      Navigator.of(context).pop();
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
                // Call deleteHewan method from your controller
                // Example assuming deleteHewan exists in your HewanController
                Get.find<HewanController>().deleteHewan(role, idHewan);
                Navigator.of(context).pop();
              },
              child: Text('Hapus'),
            ),
          ],
        );
      },
    );
  }
}
