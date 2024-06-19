import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Hewan/controllers/hewan_controller.dart';
import 'package:klinik_hewan/app/modules/Hewan/models/hewan.dart';
import 'package:klinik_hewan/services/local_storage_service.dart';

class HewanView extends StatelessWidget {
  final HewanController controller = Get.put(HewanController());

  @override
  Widget build(BuildContext context) {
    // Fetch data saat halaman pertama kali di-load
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      controller.fetchDataHewan();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Hewan'),
        centerTitle: true,
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.errorMessage.isNotEmpty) {
            return Center(
              child: Text('Error: ${controller.errorMessage.value}'),
            );
          } else if (controller.hewanList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Tidak ada data hewan'),
                  ElevatedButton(
                    onPressed: () {
                      _addHewan(context);
                    },
                    child: Text('Tambah Hewan'),
                  ),
                ],
              ),
            );
          } else {
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
                        Text('Nama Pemilik: ${hewan.namaPemilik ?? ''}'),
                        Text('Jenis: ${hewan.jenisHewan ?? ''}'),
                        Text('Umur: ${hewan.umur ?? ''} tahun'),
                        Text('Berat: ${hewan.berat ?? ''} kg'),
                        Text('Jenis Kelamin: ${hewan.jenisKelamin ?? ''}'),
                      ],
                    ),
                    trailing: Wrap(
                      spacing: 8.0,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _editHewan(context, hewan);
                          },
                        ),
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
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addHewan(context);
        },
        child: Icon(Icons.add),
      ),
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
                // Validasi input
                if (namaController.text.isNotEmpty &&
                    jenisController.text.isNotEmpty &&
                    umurController.text.isNotEmpty &&
                    beratController.text.isNotEmpty &&
                    jenisKelaminController.text.isNotEmpty) {
                  final newHewan = Hewan(
                    idHewan: 0,
                    idPemilik:
                        0, // Dilakukan oleh backend, tidak diperlukan di frontend
                    namaHewan: namaController.text,
                    jenisHewan: jenisController.text,
                    umur: int.tryParse(umurController.text) ?? 0,
                    berat: double.tryParse(beratController.text) ?? 0.0,
                    jenisKelamin: jenisKelaminController.text,
                    namaPemilik: '', // Dilakukan oleh FutureBuilder
                  );
                  controller.createHewan('admin', newHewan);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Semua field harus diisi'),
                    ),
                  );
                }
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
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
                // Validasi input
                if (namaController.text.isNotEmpty &&
                    jenisController.text.isNotEmpty &&
                    umurController.text.isNotEmpty &&
                    beratController.text.isNotEmpty &&
                    jenisKelaminController.text.isNotEmpty) {
                  final updatedHewan = Hewan(
                    idHewan: hewan.idHewan,
                    idPemilik: hewan
                        .idPemilik, // Dilakukan oleh backend, tidak diperlukan di frontend
                    namaHewan: namaController.text,
                    jenisHewan: jenisController.text,
                    umur: int.tryParse(umurController.text) ?? 0,
                    berat: double.tryParse(beratController.text) ?? 0.0,
                    jenisKelamin: jenisKelaminController.text,
                    namaPemilik: '', // Dilakukan oleh FutureBuilder
                  );
                  controller.updateHewan('admin', updatedHewan);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Semua field harus diisi'),
                    ),
                  );
                }
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
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
                controller.deleteHewan('admin', idHewan);
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
