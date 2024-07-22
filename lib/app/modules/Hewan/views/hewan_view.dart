import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:klinik_hewan/app/modules/Hewan/controllers/hewan_controller.dart';
import 'package:klinik_hewan/app/modules/Hewan/models/hewan.dart';
import 'package:klinik_hewan/app/modules/Pemilik/models/pemilik.dart';

class HewanView extends StatelessWidget {
  final String role;
  final String token;
  final HewanController controller = Get.put(HewanController());

  HewanView({required this.role, required this.token}) {
    controller.getToken();
    controller.getRole();
    controller.getDataHewan(role);
    controller.getDataPemilik(role);
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
        title: Text('Daftar Hewan'),
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
          } else if (controller.hewanList.isEmpty) {
            return _buildEmptyState(context);
          } else {
            return _buildHewanList(context);
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
              _addHewan(context, token);
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
          Text('Tidak ada data hewan'),
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
                  Text('ID Pemilik: ${hewan.idPemilik ?? ''}'),
                  Text('Jenis: ${hewan.jenisHewan ?? ''}'),
                  Text('Umur: ${hewan.umur ?? ''} tahun'),
                  Text('Berat: ${hewan.berat ?? ''} kg'),
                  Text('Jenis Kelamin: ${hewan.jenisKelamin ?? ''}'),
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
                    ));
              })),
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
    Pemilik? selectedPemilik;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFffc26f),
          title: Text('Tambah Hewan'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() {
                  if (controller.isLoading.value) {
                    return CircularProgressIndicator();
                  } else if (controller.pemilikList.isEmpty) {
                    return Text('Tidak ada data pemilik');
                  } else {
                    return DropdownButtonFormField<Pemilik>(
                      value: selectedPemilik,
                      hint: Text('Pilih Pemilik'),
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      onChanged: (Pemilik? newValue) {
                        selectedPemilik = newValue;
                      },
                      items: controller.pemilikList.map((Pemilik pemilik) {
                        return DropdownMenuItem<Pemilik>(
                          value: pemilik,
                          child: Text(pemilik.namaPemilik ?? ''),
                        );
                      }).toList(),
                    );
                  }
                }),
                // TextField(
                //   controller: idPemilikController,
                //   decoration: InputDecoration(
                //     labelText: 'ID Pemilik',
                //     border: OutlineInputBorder(),
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: namaController,
                  decoration: InputDecoration(
                      labelText: 'Nama Hewan', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: jenisController,
                  decoration: InputDecoration(
                      labelText: 'Jenis Hewan', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: umurController,
                  decoration: InputDecoration(
                      labelText: 'Umur', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: beratController,
                  decoration: InputDecoration(
                      labelText: 'Berat (kg)', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: jenisKelaminController,
                  decoration: InputDecoration(
                      labelText: 'Jenis Kelamin', border: OutlineInputBorder()),
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
                  _validateAndSaveHewan(
                      context,
                      token,
                      selectedPemilik,
                      // idPemilikController,
                      namaController,
                      jenisController,
                      umurController,
                      beratController,
                      jenisKelaminController);
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

  void _validateAndSaveHewan(
      BuildContext context,
      String token,
      Pemilik? selectedPemilik,
      // TextEditingController idPemilikController,
      TextEditingController namaController,
      TextEditingController jenisController,
      TextEditingController umurController,
      TextEditingController beratController,
      TextEditingController jenisKelaminController) {
    if (selectedPemilik != null &&
        // idPemilikController.text.isNotEmpty &&
        namaController.text.isNotEmpty &&
        jenisController.text.isNotEmpty &&
        umurController.text.isNotEmpty &&
        beratController.text.isNotEmpty &&
        jenisKelaminController.text.isNotEmpty) {
      final newHewan = Hewan(
        idHewan: 0,
        idPemilik: selectedPemilik.idPemilik,
        // int.tryParse(idPemilikController.text) ?? 0,
        namaHewan: namaController.text,
        jenisHewan: jenisController.text,
        umur: int.tryParse(umurController.text) ?? 0,
        berat: double.tryParse(beratController.text) ?? 0.0,
        jenisKelamin: jenisKelaminController.text,
      );
      Get.find<HewanController>().postDataHewan(newHewan).then((_) {
        // Reset form fields after successful submission
        // idPemilikController.clear();
        namaController.clear();
        jenisController.clear();
        umurController.clear();
        beratController.clear();
        jenisKelaminController.clear();

        // Get.back(); // Close dialog after successful submission
      }).catchError((error) {
        // Handle specific errors or show generic error message
        Get.defaultDialog(
          title: 'Error',
          middleText: 'Failed to create hewan: $error',
        );
      });
    } else {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Semua field harus diisi',
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
                  decoration: InputDecoration(
                      labelText: 'Nama Hewan', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: jenisController,
                  decoration: InputDecoration(
                      labelText: 'Jenis Hewan', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: umurController,
                  decoration: InputDecoration(
                      labelText: 'Umur', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: beratController,
                  decoration: InputDecoration(
                      labelText: 'Berat (kg)', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: jenisKelaminController,
                  decoration: InputDecoration(
                      labelText: 'Jenis Kelamin', border: OutlineInputBorder()),
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
                  _validateAndEditHewan(
                      context,
                      hewan,
                      namaController,
                      jenisController,
                      umurController,
                      beratController,
                      jenisKelaminController);
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
      Get.find<HewanController>().updateHewan(updatedHewan);
      Navigator.of(context).pop();
    } else {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Semua field harus diisi',
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
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                )),
            ElevatedButton(
                onPressed: () {
                  // Call deleteHewan method from your controller
                  // Example assuming deleteHewan exists in your HewanController
                  Get.find<HewanController>().deleteHewan(idHewan);
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
