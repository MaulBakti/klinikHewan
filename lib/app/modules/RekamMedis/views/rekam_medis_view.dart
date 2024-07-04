import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/RekamMedis/controllers/rekam_medis_controller.dart';
import 'package:klinik_hewan/app/modules/RekamMedis/model/rekamMedis.dart';

class RekamMedisView extends StatelessWidget {
  final String role;
  final String token;
  final RekamMedisController controller = Get.put(RekamMedisController());

  RekamMedisView({required this.role, required this.token}) {
    controller.getToken();
    controller.getRole();
    controller.getDataRekamMedis(role);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Rekam Medis'),
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
        } else if (controller.rekammedisList.isEmpty) {
          return _buildEmptyState(context);
        } else {
          return _buildrekammedisList(context);
        }
      }),
      floatingActionButton: role == 'admin' || role == 'pegawai'
          ? FloatingActionButton(
              onPressed: () {
                print(role);
                _addrekammedis(context, token);
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
          Text('Tidak ada data Rekam Medis'),
        ],
      ),
    );
  }

  Widget _buildrekammedisList(BuildContext context) {
    return ListView.builder(
      itemCount: controller.rekammedisList.length,
      itemBuilder: (context, index) {
        final rekammedis = controller.rekammedisList[index];
        return Card(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(rekammedis.namaHewan ?? ''),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ID Pemilik: ${rekammedis.idPemilik ?? ''}'),
                Text('Jenis: ${rekammedis.namaPegawai ?? ''}'),
                Text('Jenis Kelamin: ${rekammedis.diagnosa ?? ''}'),
              ],
            ),
            trailing: Wrap(
              spacing: 8.0,
              children: [
                if (role == 'admin' || role == 'pegawai')
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _editrekammedis(context, rekammedis);
                    },
                  ),
                if (role == 'admin')
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _confirmDelete(context, rekammedis.idRekamMedis ?? 0);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addrekammedis(BuildContext context, String token) {
    final TextEditingController idHewanController = TextEditingController();
    final TextEditingController idPemilikController = TextEditingController();
    final TextEditingController idPegawaiController = TextEditingController();
    final TextEditingController idobatController = TextEditingController();
    final TextEditingController keluhanController = TextEditingController();
    final TextEditingController diagnosaController = TextEditingController();
    final TextEditingController tglPeriksaController = TextEditingController();
    final TextEditingController namaHewanController = TextEditingController();
    final TextEditingController namaPemilikController = TextEditingController();
    final TextEditingController namaPegawaiController = TextEditingController();
    final TextEditingController namaObatController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah rekammedis'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: idHewanController,
                  decoration: InputDecoration(
                    labelText: 'ID Hewan',
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  controller: idPemilikController,
                  decoration: InputDecoration(
                    labelText: 'ID Pemilik',
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  controller: idPegawaiController,
                  decoration: InputDecoration(
                    labelText: 'ID Pegawai',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: idobatController,
                  decoration: InputDecoration(
                    labelText: 'ID Obat',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: keluhanController,
                  decoration: InputDecoration(
                      labelText: 'Keluhan', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: diagnosaController,
                  decoration: InputDecoration(
                      labelText: 'Diagnosa', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: tglPeriksaController,
                  decoration: InputDecoration(
                      labelText: 'Tgl Periksa', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: namaHewanController,
                  decoration: InputDecoration(
                      labelText: 'Nama Hewan', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: namaPemilikController,
                  decoration: InputDecoration(
                      labelText: 'Nama Pemilik', border: OutlineInputBorder()),
                ),
                TextField(
                  controller: namaPegawaiController,
                  decoration: InputDecoration(
                    labelText: 'Nama Pegawai',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: namaObatController,
                  decoration: InputDecoration(
                    labelText: 'Nama Obat',
                    border: OutlineInputBorder(),
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
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                )),
            ElevatedButton(
                onPressed: () {
                  _validateAndSaverekammedis(
                      context,
                      token,
                      idHewanController,
                      idPemilikController,
                      idPegawaiController,
                      idobatController,
                      keluhanController,
                      diagnosaController,
                      tglPeriksaController,
                      namaHewanController,
                      namaPemilikController,
                      namaPegawaiController,
                      namaObatController);
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

  void _validateAndSaverekammedis(
      BuildContext context,
      String token,
      TextEditingController idHewanController,
      TextEditingController idPemilikController,
      TextEditingController idPegawaiController,
      TextEditingController idobatController,
      TextEditingController keluhanController,
      TextEditingController diagnosaController,
      TextEditingController tglPeriksaController,
      TextEditingController namaHewanController,
      TextEditingController namaPemilikController,
      TextEditingController namaPegawaiController,
      TextEditingController namaObatController) {
    if (idHewanController.text.isNotEmpty &&
        idPemilikController.text.isNotEmpty &&
        idPegawaiController.text.isNotEmpty &&
        idobatController.text.isNotEmpty &&
        keluhanController.text.isNotEmpty &&
        diagnosaController.text.isNotEmpty &&
        tglPeriksaController.text.isNotEmpty &&
        namaHewanController.text.isNotEmpty &&
        namaPemilikController.text.isNotEmpty &&
        namaPegawaiController.text.isNotEmpty &&
        namaObatController.text.isNotEmpty) {
      final newrekammedis = rekamMedis(
        idRekamMedis: 0,
        idHewan: int.tryParse(idHewanController.text) ?? 0,
        idPemilik: int.tryParse(idPemilikController.text) ?? 0,
        idPegawai: int.tryParse(idPegawaiController.text) ?? 0,
        idObat: int.tryParse(idobatController.text) ?? 0,
        keluhan: keluhanController.text,
        diagnosa: diagnosaController.text,
        tglPeriksa: tglPeriksaController.text,
        namaHewan: namaHewanController.text,
        namaPemilik: namaPemilikController.text,
        namaPegawai: namaPegawaiController.text,
        namaObat: namaObatController.text,
      );
      Get.find<RekamMedisController>()
          .postDataRekamMedis(newrekammedis)
          .then((_) {
        // Reset form fields after successful submission
        idPemilikController.clear();
        idHewanController.clear();
        idHewanController.clear();
        idPemilikController.clear();
        idPegawaiController.clear();
        idobatController.clear();
        keluhanController.clear();
        diagnosaController.clear();
        tglPeriksaController.clear();
        namaHewanController.clear();
        namaPemilikController.clear();
        namaPegawaiController.clear();
        namaObatController.clear();
        // Get.back(); // Close dialog after successful submission
      }).catchError((error) {
        // Handle specific errors or show generic error message
        Get.defaultDialog(
          title: 'Error',
          middleText: 'Failed to create rekammedis: $error',
        );
      });
    } else {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Semua field harus diisi',
      );
    }
  }

  void _editrekammedis(BuildContext context, rekamMedis rekammedis) {
    final TextEditingController idHewanController =
        TextEditingController(text: rekammedis.idHewan.toString());
    final TextEditingController idPemilikController =
        TextEditingController(text: rekammedis.idPemilik.toString());
    final TextEditingController idPegawaiController =
        TextEditingController(text: rekammedis.idPegawai.toString());
    final TextEditingController idobatController =
        TextEditingController(text: rekammedis.idObat.toString());
    final TextEditingController keluhanController =
        TextEditingController(text: rekammedis.keluhan);
    final TextEditingController diagnosaController =
        TextEditingController(text: rekammedis.diagnosa);
    final TextEditingController tglPeriksaController =
        TextEditingController(text: rekammedis.tglPeriksa);
    final TextEditingController namaHewanController =
        TextEditingController(text: rekammedis.namaHewan);
    final TextEditingController namaPemilikController =
        TextEditingController(text: rekammedis.namaPemilik);
    final TextEditingController namaPegawaiController =
        TextEditingController(text: rekammedis.namaPegawai);
    final TextEditingController namaObatController =
        TextEditingController(text: rekammedis.namaObat);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit rekammedis'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: idHewanController,
                  decoration: InputDecoration(
                    labelText: 'ID Hewan',
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  controller: idPemilikController,
                  decoration: InputDecoration(
                    labelText: 'ID Pemilik',
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  controller: idPegawaiController,
                  decoration: InputDecoration(
                    labelText: 'ID Pegawai',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: idobatController,
                  decoration: InputDecoration(
                    labelText: 'ID Obat',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: keluhanController,
                  decoration: InputDecoration(
                      labelText: 'Keluhan', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: diagnosaController,
                  decoration: InputDecoration(
                      labelText: 'Diagnosa', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: tglPeriksaController,
                  decoration: InputDecoration(
                      labelText: 'Tgl Periksa', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: namaHewanController,
                  decoration: InputDecoration(
                      labelText: 'Nama Hewan', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: namaPemilikController,
                  decoration: InputDecoration(
                      labelText: 'Nama Pemilik', border: OutlineInputBorder()),
                ),
                TextField(
                  controller: namaPegawaiController,
                  decoration: InputDecoration(
                    labelText: 'Nama Pegawai',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: namaObatController,
                  decoration: InputDecoration(
                    labelText: 'Nama Obat',
                    border: OutlineInputBorder(),
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
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                )),
            ElevatedButton(
                onPressed: () {
                  _validateAndEditrekammedis(
                      context,
                      rekammedis,
                      idHewanController,
                      idPemilikController,
                      idPegawaiController,
                      idobatController,
                      keluhanController,
                      diagnosaController,
                      tglPeriksaController,
                      namaHewanController,
                      namaPemilikController,
                      namaPegawaiController,
                      namaObatController);
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

  void _validateAndEditrekammedis(
      BuildContext context,
      rekamMedis rekammedis,
      TextEditingController idHewanController,
      TextEditingController idPemilikController,
      TextEditingController idPegawaiController,
      TextEditingController idobatController,
      TextEditingController keluhanController,
      TextEditingController diagnosaController,
      TextEditingController tglPeriksaController,
      TextEditingController namaHewanController,
      TextEditingController namaPemilikController,
      TextEditingController namaPegawaiController,
      TextEditingController namaObatController) {
    if (idHewanController.text.isNotEmpty &&
        idPemilikController.text.isNotEmpty &&
        idPegawaiController.text.isNotEmpty &&
        idobatController.text.isNotEmpty &&
        keluhanController.text.isNotEmpty &&
        diagnosaController.text.isNotEmpty &&
        tglPeriksaController.text.isNotEmpty &&
        namaHewanController.text.isNotEmpty &&
        namaPemilikController.text.isNotEmpty &&
        namaPegawaiController.text.isNotEmpty &&
        namaObatController.text.isNotEmpty) {
      final updatedrekammedis = rekamMedis(
        idRekamMedis: 0,
        idHewan: int.tryParse(idHewanController.text) ?? 0,
        idPemilik: int.tryParse(idPemilikController.text) ?? 0,
        idPegawai: int.tryParse(idPegawaiController.text) ?? 0,
        idObat: int.tryParse(idobatController.text) ?? 0,
        keluhan: keluhanController.text,
        diagnosa: diagnosaController.text,
        tglPeriksa: tglPeriksaController.text,
        namaHewan: namaHewanController.text,
        namaPemilik: namaPemilikController.text,
        namaPegawai: namaPegawaiController.text,
        namaObat: namaObatController.text,
      );
      Get.find<RekamMedisController>().updateRekamMedis(updatedrekammedis);
      Navigator.of(context).pop();
    } else {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Semua field harus diisi',
      );
    }
  }

  void _confirmDelete(BuildContext context, int idrekammedis) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus rekammedis ini?'),
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
                  // Call deleterekammedis method from your controller
                  // Example assuming deleterekammedis exists in your rekammedisController
                  Get.find<RekamMedisController>()
                      .deleteRekamMedis(idrekammedis);
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
