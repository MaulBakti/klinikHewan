import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pegawai_controller.dart';
import '../models/pegawai.dart';

class PegawaiView extends StatelessWidget {
  final String role;
  final String token;
  final PegawaiController controller = Get.put(PegawaiController());

  PegawaiView({required this.role, required this.token}) {
    controller.getToken();
    controller.getRole();
    controller.getDataPegawai(role);
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
        title: Text('Daftar Pegawai'),
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
          } else if (controller.pegawaiList.isEmpty) {
            return _buildEmptyState(context);
          } else {
            return _buildPegawaiList(context);
          }
        }),
      ),
      floatingActionButton: Obx(() {
        final role = controller.role.value;
        // Define roles that should not have a FloatingActionButton
        const restrictedRoles = ['pemilik', 'pegawai'];

        return Visibility(
          visible: !restrictedRoles.contains(role),
          child: FloatingActionButton(
            onPressed: () {
              print(role);
              _addPegawai(context, token);
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
          Text('Tidak ada data pegawai'),
        ],
      ),
    );
  }

  Widget _buildPegawaiList(BuildContext context) {
    return ListView.builder(
      itemCount: controller.pegawaiList.length,
      itemBuilder: (context, index) {
        final pegawai = controller.pegawaiList[index];
        return Card(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(pegawai.namaPegawai ?? ''),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Jabatan: ${pegawai.jabatan ?? ''}'),
                Text('Alamat: ${pegawai.alamat ?? ''}'),
                Text('No Telp: ${pegawai.noTelp ?? ''}'),
              ],
            ),
            trailing:
                role == 'admin' ? _buildAdminActions(context, pegawai) : null,
          ),
        );
      },
    );
  }

  Widget _buildAdminActions(BuildContext context, Pegawai pegawai) {
    return Wrap(
      spacing: 8.0,
      children: [
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            _editPegawai(context, pegawai);
          },
        ),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            _confirmDelete(context, pegawai.idPegawai ?? 0);
          },
        ),
      ],
    );
  }

  void _addPegawai(BuildContext context, String token) {
    final TextEditingController namaController = TextEditingController();
    final TextEditingController passwordContriller = TextEditingController();
    final TextEditingController alamatController = TextEditingController();
    final TextEditingController noTelpController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Pegawai'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: namaController,
                  decoration: InputDecoration(
                      labelText: 'Nama Pegawai', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: passwordContriller,
                  decoration: InputDecoration(
                      labelText: 'Password', border: OutlineInputBorder()),
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
                  _validateAndSavePegawai(
                    context,
                    token,
                    namaController,
                    passwordContriller,
                    alamatController,
                    noTelpController,
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

  void _validateAndSavePegawai(
      BuildContext context,
      String token,
      TextEditingController namaController,
      TextEditingController alamatController,
      TextEditingController noTelpController,
      TextEditingController passwordContriller) {
    if (namaController.text.isNotEmpty &&
        alamatController.text.isNotEmpty &&
        passwordContriller.text.isNotEmpty &&
        noTelpController.text.isNotEmpty) {
      final newPegawai = Pegawai(
        idPegawai: 0,
        namaPegawai: namaController.text,
        jabatan: 'pegawai',
        password: passwordContriller.text,
        alamat: alamatController.text,
        noTelp: noTelpController.text,
      );
      Get.find<PegawaiController>().postDataPegawai(newPegawai).then((_) {
        // Reset form fields after successful submission
        namaController.clear();
        passwordContriller.clear();
        alamatController.clear();
        noTelpController.clear();

        // Get.back(); // Close dialog after successful submission
      }).catchError((error) {
        // Handle specific errors or show generic error message
        Get.defaultDialog(
          title: 'Error',
          middleText: 'Failed to create pegawai: $error',
        );
      });
    } else {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Semua field harus diisi',
      );
    }
  }

  void _editPegawai(BuildContext context, Pegawai pegawai) {
    final TextEditingController namaController =
        TextEditingController(text: pegawai.namaPegawai);
    final TextEditingController passwordContriller =
        TextEditingController(text: pegawai.password);
    final TextEditingController alamatController =
        TextEditingController(text: pegawai.alamat);
    final TextEditingController noTelpController =
        TextEditingController(text: pegawai.noTelp);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Pegawai'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: namaController,
                  decoration: InputDecoration(
                      labelText: 'Nama Pegawai', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: passwordContriller,
                  decoration: InputDecoration(
                      labelText: 'Password', border: OutlineInputBorder()),
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
                  _validateAndEditPegawai(
                    context,
                    pegawai,
                    namaController,
                    passwordContriller,
                    alamatController,
                    noTelpController,
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

  void _validateAndEditPegawai(
    BuildContext context,
    Pegawai pegawai,
    TextEditingController namaController,
    TextEditingController alamatController,
    TextEditingController noTelpController,
    TextEditingController passwordContriller,
  ) {
    if (namaController.text.isNotEmpty &&
        alamatController.text.isNotEmpty &&
        passwordContriller.text.isNotEmpty &&
        noTelpController.text.isNotEmpty) {
      final updatedPegawai = Pegawai(
        idPegawai: pegawai.idPegawai,
        namaPegawai: namaController.text,
        jabatan: 'pegawai',
        password: passwordContriller.text,
        alamat: alamatController.text,
        noTelp: noTelpController.text,
      );
      Get.find<PegawaiController>().updatePegawai(updatedPegawai);
      Navigator.of(context).pop();
    } else {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Semua field harus diisi',
      );
    }
  }

  void _confirmDelete(BuildContext context, int idPegawai) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus pegawai ini?'),
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
                  // Call deletepegawai method from your controller
                  // Example assuming deletepegawai exists in your pegawaiController
                  Get.find<PegawaiController>().deletePegawai(idPegawai);
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
