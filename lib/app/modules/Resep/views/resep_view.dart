import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/resep_controller.dart';
import 'package:klinik_hewan/app/modules/Resep/model/resep.dart';

class ResepView extends StatelessWidget {
  final String role;
  final String token;
  final ResepController controller = Get.put(ResepController());

  ResepView({required this.role, required this.token}) {
    controller.getToken();
    controller.getRole();
    controller.getDataResep(role);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.toNamed('/home');
          },
        ),
        title: Text('Daftar Resep'),
        backgroundColor: Color(0xFFFFE4C4),
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
        } else if (controller.resepList.isEmpty) {
          return _buildEmptyState(context);
        } else {
          return _buildResepList(context);
        }
      }),
      floatingActionButton: Obx(() {
        final role = controller.role.value;
        // Define roles that should not have a FloatingActionButton
        const restrictedRoles = ['pemilik'];

        return Visibility(
          visible: !restrictedRoles.contains(role),
          child: FloatingActionButton(
            onPressed: () {
              print(role);
              _addResep(context, token);
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
          Text('Tidak ada data resep'),
        ],
      ),
    );
  }

  Widget _buildResepList(BuildContext context) {
    return ListView.builder(
      itemCount: controller.resepList.length,
      itemBuilder: (context, index) {
        final resep = controller.resepList[index];
        return Card(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text('ID Resep: ${resep.idResep.toString()}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ID Rekam Medis: ${resep.idRekamMedis.toString()}'),
                Text('ID Obat: ${resep.idObat.toString()}'),
                Text('Jumlah Obat: ${resep.jumlahObat.toString()}'),
              ],
            ),
            trailing: Wrap(
              spacing: 8.0,
              children: [
                if (role == 'admin' || role == 'pegawai')
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _editResep(context, resep);
                    },
                  ),
                if (role == 'admin')
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _confirmDelete(context, resep.idResep ?? 0);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addResep(BuildContext context, String token) {
    final TextEditingController idRekamMedisController =
        TextEditingController();
    final TextEditingController idObatController = TextEditingController();
    final TextEditingController jumlahObatController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Resep'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: idRekamMedisController,
                  decoration: InputDecoration(
                      labelText: 'Rekam Medis', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: idObatController,
                  decoration: InputDecoration(
                      labelText: 'Id Obat', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: jumlahObatController,
                  decoration: InputDecoration(
                      labelText: 'Jumlah Obat', border: OutlineInputBorder()),
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
                  _validateAndSaveResep(
                    context,
                    token,
                    idRekamMedisController,
                    idObatController,
                    jumlahObatController,
                  );
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

  void _validateAndSaveResep(
    BuildContext context,
    String token,
    TextEditingController idRekamMedisController,
    TextEditingController idObatController,
    TextEditingController jumlahObatController,
  ) {
    if (idRekamMedisController.text.isNotEmpty &&
        idObatController.text.isNotEmpty &&
        jumlahObatController.text.isNotEmpty) {
      final newResep = Resep(
        idResep: 0,
        idRekamMedis: int.tryParse(idRekamMedisController.text) ?? 0,
        idObat: int.tryParse(idObatController.text) ?? 0,
        jumlahObat: int.tryParse(jumlahObatController.text) ?? 0,
      );
      Get.find<ResepController>().postDataResep(newResep).then((_) {
        // Reset form fields after successful submission
        idRekamMedisController.clear();
        idObatController.clear();
        jumlahObatController.clear();

        // Get.back(); // Close dialog after successful submission
      }).catchError((error) {
        // Handle specific errors or show generic error message
        Get.defaultDialog(
          title: 'Error',
          middleText: 'Failed to create resep: $error',
        );
      });
    } else {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Semua field harus diisi',
      );
    }
  }

  void _editResep(BuildContext context, Resep resep) {
    final TextEditingController idRekamMedisController =
        TextEditingController(text: resep.idRekamMedis.toString());
    final TextEditingController idObatController =
        TextEditingController(text: resep.idObat.toString());
    final TextEditingController jumlahObatController =
        TextEditingController(text: resep.jumlahObat.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Resep'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: idRekamMedisController,
                  decoration: InputDecoration(
                      labelText: 'Rekam Medis', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: idObatController,
                  decoration: InputDecoration(
                      labelText: 'Obat', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: jumlahObatController,
                  decoration: InputDecoration(
                      labelText: 'Jumlah Obat', border: OutlineInputBorder()),
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
                  _validateAndEditResep(
                    context,
                    resep,
                    idRekamMedisController,
                    idObatController,
                    jumlahObatController,
                  );
                  Get.back();
                },
                child: Text('Edit'),
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

  void _validateAndEditResep(
      BuildContext context,
      Resep resep,
      TextEditingController idRekamMedisController,
      TextEditingController idObatController,
      TextEditingController jumlahObatController) {
    if (idRekamMedisController.text.isNotEmpty &&
        idObatController.text.isNotEmpty &&
        jumlahObatController.text.isNotEmpty) {
      final updatedResep = Resep(
          idResep: resep.idResep,
          idRekamMedis: int.tryParse(idRekamMedisController.text) ?? 0,
          idObat: int.tryParse(idObatController.text) ?? 0,
          jumlahObat: int.tryParse(jumlahObatController.text) ?? 0);
      Get.find<ResepController>().updateResep(updatedResep);
      Navigator.of(context).pop();
    } else {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Semua field harus diisi',
      );
    }
  }

  void _confirmDelete(BuildContext context, int idResep) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus resep ini?'),
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
                  // Call deleteresep method from your controller
                  // Example assuming deleteresep exists in your resepController
                  Get.find<ResepController>().deleteResep(idResep);
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
