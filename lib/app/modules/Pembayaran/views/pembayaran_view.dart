import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pembayaran_controller.dart';
import '../model/pembayaran.dart';

class pembayaranView extends StatelessWidget {
  final pembayaranController controller = Get.put(pembayaranController());
  final String role;
  final String token;

  pembayaranView({required this.role, required this.token}) {
    controller.getToken();
    controller.getRole();
    controller.getDataPembayaran(role, token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Pembayaran'),
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
      floatingActionButton: Visibility(
        visible: !_isRestrictedRole(role),
        child: FloatingActionButton(
          onPressed: () {
            _addPembayaran(context, token);
          },
          child: Icon(Icons.add),
        ),
      ),
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
            title: Text("ID Rekam Medis: ${pembayaran.idRekamMedis}"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Jumlah Pembayaran: ${pembayaran.jumlahPembayaran}'),
                Text('Tanggal Pembayaran: ${pembayaran.tanggalPembayaran}'),
                Text('Bukti Pemmbayaran: ${pembayaran.buktiPembayaran}'),
              ],
            ),
            trailing: Wrap(
              spacing: 8.0,
              children: [
                if (_isAdminOrPegawai(role))
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
                      _confirmDelete(context,
                          int.tryParse(pembayaran.idPembayaran ?? '0') ?? 0);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addPembayaran(BuildContext context, String token) {
    final TextEditingController idRekamMedisController =
        TextEditingController();
    final TextEditingController jumlahController = TextEditingController();
    final TextEditingController tanggalController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Pembayaran'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: idRekamMedisController,
                  decoration: InputDecoration(
                      labelText: 'ID Rekam Medis',
                      border: OutlineInputBorder()),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: jumlahController,
                  decoration: InputDecoration(
                      labelText: 'Jumlah Pembayaran',
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                TextField(
                  controller: tanggalController,
                  decoration: InputDecoration(
                      labelText: 'Tanggal Pembayaran (yyyy-mm-dd)',
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.datetime,
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
                _validateAndSavePembayaran(
                  context,
                  token,
                  idRekamMedisController,
                  jumlahController,
                  tanggalController,
                );
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
    TextEditingController idRekamMedisController,
    TextEditingController jumlahController,
    TextEditingController tanggalController,
  ) {
    if (idRekamMedisController.text.isNotEmpty &&
        jumlahController.text.isNotEmpty &&
        tanggalController.text.isNotEmpty) {
      final newPembayaran = Pembayaran(
        idRekamMedis: idRekamMedisController.text,
        jumlahPembayaran: double.tryParse(jumlahController.text) ?? 0.0,
        tanggalPembayaran: DateTime.tryParse(tanggalController.text),
      );

      Get.find<pembayaranController>()
          .CreatePembayaran(role, token, newPembayaran)
          .then((_) {
        idRekamMedisController.clear();
        jumlahController.clear();
        tanggalController.clear();
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
    final TextEditingController idRekamMedisController =
        TextEditingController(text: pembayaran.idRekamMedis);
    final TextEditingController jumlahController =
        TextEditingController(text: pembayaran.jumlahPembayaran.toString());
    final TextEditingController tanggalController = TextEditingController(
        text: pembayaran.tanggalPembayaran?.toIso8601String().split('T')[0]);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Pembayaran'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: idRekamMedisController,
                  decoration: InputDecoration(
                      labelText: 'ID Rekam Medis',
                      border: OutlineInputBorder()),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: jumlahController,
                  decoration: InputDecoration(
                      labelText: 'Jumlah Pembayaran',
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                TextField(
                  controller: tanggalController,
                  decoration: InputDecoration(
                      labelText: 'Tanggal Pembayaran (yyyy-mm-dd)',
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.datetime,
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
                _validateAndEditPembayaran(
                  context,
                  pembayaran,
                  idRekamMedisController,
                  jumlahController,
                  tanggalController,
                );
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _validateAndEditPembayaran(
    BuildContext context,
    Pembayaran pembayaran,
    TextEditingController idRekamMedisController,
    TextEditingController jumlahController,
    TextEditingController tanggalController,
  ) {
    if (idRekamMedisController.text.isNotEmpty &&
        jumlahController.text.isNotEmpty &&
        tanggalController.text.isNotEmpty) {
      final updatedPembayaran = Pembayaran(
        idPembayaran: pembayaran.idPembayaran,
        idRekamMedis: idRekamMedisController.text,
        jumlahPembayaran: double.tryParse(jumlahController.text) ?? 0.0,
        tanggalPembayaran: DateTime.tryParse(tanggalController.text),
      );

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
            ),
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
            ),
          ],
        );
      },
    );
  }

  bool _isAdminOrPegawai(String role) {
    return role == 'admin' || role == 'pegawai';
  }

  bool _isRestrictedRole(String role) {
    const restrictedRoles = ['pemilik']; // Modify as needed
    return restrictedRoles.contains(role);
  }
}
