import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/RekamMedis/controllers/rekam_medis_controller.dart';
import 'package:klinik_hewan/app/modules/RekamMedis/model/rekamMedis.dart';
import 'package:klinik_hewan/app/modules/Hewan/models/hewan.dart';
import 'package:klinik_hewan/app/modules/Pemilik/models/pemilik.dart';
import 'package:klinik_hewan/app/modules/Pegawai/models/pegawai.dart';
import 'package:klinik_hewan/app/modules/Obat/model/obat.dart';

class RekamMedisView extends StatelessWidget {
  final String role;
  final String token;
  final RekamMedisController controller = Get.put(RekamMedisController());

  RekamMedisView({required this.role, required this.token}) {
    controller.getToken();
    controller.getRole();
    controller.getDataRekamMedis(role);
    controller.getDataPemilik(role);
    controller.getDataHewan(role);
    controller.getDataPegawai(role);
    controller.getDataObat(role);
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
            title: Text('Nama Hewan: ${rekammedis.namaHewan}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nama Pemilik: ${rekammedis.namaPemilik ?? ''}'),
                Text('Keluhan: ${rekammedis.keluhan ?? ''}'),
                Text('Diagnosa: ${rekammedis.diagnosa ?? ''}'),
                Text('Tanggal Periksa: ${rekammedis.tglPeriksa ?? ''}'),
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
    final TextEditingController keluhanController = TextEditingController();
    final TextEditingController diagnosaController = TextEditingController();
    final TextEditingController tglPeriksaController = TextEditingController();
    Pemilik? selectedPemilik;
    Hewan? selectedHewan;
    Pegawai? selectedPegawai;
    Obat? selectedObat;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah rekammedis'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() {
                  if (controller.isLoading.value) {
                    return CircularProgressIndicator();
                  } else if (controller.hewanList.isEmpty) {
                    return Text('Tidak ada data Hewan');
                  } else {
                    return DropdownButtonFormField<Hewan>(
                      value: selectedHewan,
                      hint: Text('Pilih Hewan'),
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      onChanged: (Hewan? newValue) {
                        selectedHewan = newValue;
                      },
                      items: controller.hewanList.map((Hewan hewan) {
                        return DropdownMenuItem<Hewan>(
                          value: hewan,
                          child: Text(hewan.namaHewan ?? ''),
                        );
                      }).toList(),
                    );
                  }
                }),
                SizedBox(
                  height: 10,
                ),
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
                SizedBox(
                  height: 10,
                ),
                Obx(() {
                  if (controller.isLoading.value) {
                    return CircularProgressIndicator();
                  } else if (controller.pegawaiList.isEmpty) {
                    return Text('Tidak ada data pegawai');
                  } else {
                    return DropdownButtonFormField<Pegawai>(
                      value: selectedPegawai,
                      hint: Text('Pilih Pegawai'),
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      onChanged: (Pegawai? newValue) {
                        selectedPegawai = newValue;
                      },
                      items: controller.pegawaiList.map((Pegawai pegawai) {
                        return DropdownMenuItem<Pegawai>(
                          value: pegawai,
                          child: Text(pegawai.namaPegawai ?? ''),
                        );
                      }).toList(),
                    );
                  }
                }),
                SizedBox(
                  height: 10,
                ),
                Obx(() {
                  if (controller.isLoading.value) {
                    return CircularProgressIndicator();
                  } else if (controller.obatList.isEmpty) {
                    return Text('Tidak ada data obat');
                  } else {
                    return DropdownButtonFormField<Obat>(
                      value: selectedObat,
                      hint: Text('Pilih Obat'),
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      onChanged: (Obat? newValue) {
                        selectedObat = newValue;
                      },
                      items: controller.obatList.map((Obat obat) {
                        return DropdownMenuItem<Obat>(
                          value: obat,
                          child: Text(obat.namaObat ?? ''),
                        );
                      }).toList(),
                    );
                  }
                }),
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
                GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                      tglPeriksaController.text = formattedDate;
                    }
                  },
                  child: AbsorbPointer(
                    child: TextField(
                      controller: tglPeriksaController,
                      decoration: InputDecoration(
                        labelText: 'Tgl Periksa',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
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
                      selectedPemilik,
                      selectedHewan,
                      selectedPegawai,
                      selectedObat,
                      keluhanController,
                      diagnosaController,
                      tglPeriksaController);
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
    Pemilik? selectedPemilik,
    Hewan? selectedHewan,
    Pegawai? selectedPegawai,
    Obat? selectedObat,
    TextEditingController keluhanController,
    TextEditingController diagnosaController,
    TextEditingController tglPeriksaController,
  ) {
    if (selectedPemilik != null &&
        selectedHewan != null &&
        selectedHewan.namaHewan != null &&
        selectedPegawai != null &&
        selectedObat != null &&
        keluhanController.text.isNotEmpty &&
        diagnosaController.text.isNotEmpty &&
        tglPeriksaController.text.isNotEmpty) {
      final newrekammedis = rekamMedis(
        idRekamMedis: 0,
        idHewan: selectedHewan.idHewan ?? 0,
        namaHewan: selectedHewan.namaHewan ?? '',
        idPemilik: selectedPemilik.idPemilik,
        namaPemilik: selectedPemilik.namaPemilik ?? '',
        idPegawai: selectedPegawai.idPegawai,
        namaPegawai: selectedPegawai.namaPegawai ?? '',
        idObat: selectedObat.idObat,
        namaObat: selectedObat.namaObat ?? '',
        keluhan: keluhanController.text,
        diagnosa: diagnosaController.text,
        tglPeriksa: tglPeriksaController.text,
      );
      Get.find<RekamMedisController>()
          .postDataRekamMedis(newrekammedis)
          .then((_) {
        keluhanController.clear();
        diagnosaController.clear();
        tglPeriksaController.clear();
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
    Pemilik? selectedPemilik = controller.pemilikList.firstWhere(
      (pemilik) => pemilik.idPemilik == rekammedis.idPemilik,
    );
    Hewan? selectedHewan = controller.hewanList.firstWhere(
      (hewan) => hewan.idHewan == rekammedis.idHewan,
    );
    Pegawai? selectedPegawai = controller.pegawaiList.firstWhere(
      (pegawai) => pegawai.idPegawai == rekammedis.idPegawai,
    );
    Obat? selectedObat = controller.obatList.firstWhere(
      (obat) => obat.idObat == rekammedis.idObat,
    );
    final TextEditingController keluhanController =
        TextEditingController(text: rekammedis.keluhan);
    final TextEditingController diagnosaController =
        TextEditingController(text: rekammedis.diagnosa);
    final TextEditingController tglPeriksaController =
        TextEditingController(text: rekammedis.tglPeriksa);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit rekammedis'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() {
                  if (controller.isLoading.value) {
                    return CircularProgressIndicator();
                  } else if (controller.hewanList.isEmpty) {
                    return Text('Tidak ada data Hewan');
                  } else {
                    return DropdownButtonFormField<Hewan>(
                      value: selectedHewan,
                      hint: Text('Pilih Hewan'),
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      onChanged: (Hewan? newValue) {
                        selectedHewan = newValue;
                      },
                      items: controller.hewanList.map((Hewan hewan) {
                        return DropdownMenuItem<Hewan>(
                          value: hewan,
                          child: Text(hewan.namaHewan ?? ''),
                        );
                      }).toList(),
                    );
                  }
                }),
                SizedBox(
                  height: 10,
                ),
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
                SizedBox(
                  height: 10,
                ),
                Obx(() {
                  if (controller.isLoading.value) {
                    return CircularProgressIndicator();
                  } else if (controller.pegawaiList.isEmpty) {
                    return Text('Tidak ada data pegawai');
                  } else {
                    return DropdownButtonFormField<Pegawai>(
                      value: selectedPegawai,
                      hint: Text('Pilih Pegawai'),
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      onChanged: (Pegawai? newValue) {
                        selectedPegawai = newValue;
                      },
                      items: controller.pegawaiList.map((Pegawai pegawai) {
                        return DropdownMenuItem<Pegawai>(
                          value: pegawai,
                          child: Text(pegawai.namaPegawai ?? ''),
                        );
                      }).toList(),
                    );
                  }
                }),
                SizedBox(
                  height: 10,
                ),
                Obx(() {
                  if (controller.isLoading.value) {
                    return CircularProgressIndicator();
                  } else if (controller.obatList.isEmpty) {
                    return Text('Tidak ada data obat');
                  } else {
                    return DropdownButtonFormField<Obat>(
                      value: selectedObat,
                      hint: Text('Pilih Obat'),
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      onChanged: (Obat? newValue) {
                        selectedObat = newValue;
                      },
                      items: controller.obatList.map((Obat obat) {
                        return DropdownMenuItem<Obat>(
                          value: obat,
                          child: Text(obat.namaObat ?? ''),
                        );
                      }).toList(),
                    );
                  }
                }),
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
                GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                      tglPeriksaController.text = formattedDate;
                    }
                  },
                  child: AbsorbPointer(
                    child: TextField(
                      controller: tglPeriksaController,
                      decoration: InputDecoration(
                        labelText: 'Tgl Periksa',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
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
                  _validateAndEditrekammedis(
                      context,
                      rekammedis,
                      selectedPemilik,
                      selectedHewan,
                      selectedPegawai,
                      selectedObat,
                      keluhanController,
                      diagnosaController,
                      tglPeriksaController
                      // namaHewanController,
                      // namaPemilikController,
                      // namaPegawaiController,
                      // namaObatController
                      );
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
    // TextEditingController idHewanController,
    // TextEditingController idPemilikController,
    // TextEditingController idPegawaiController,
    // TextEditingController idobatController,
    Pemilik? selectedPemilik,
    Hewan? selectedHewan,
    Pegawai? selectedPegawai,
    Obat? selectedObat,
    TextEditingController keluhanController,
    TextEditingController diagnosaController,
    TextEditingController tglPeriksaController,
    // TextEditingController namaHewanController,
    // TextEditingController namaPemilikController,
    // TextEditingController namaPegawaiController,
    // TextEditingController namaObatController
  ) {
    if (selectedPemilik != null &&
            selectedHewan != null &&
            selectedPegawai != null &&
            selectedObat != null &&
            // idHewanController.text.isNotEmpty &&
            //       idPemilikController.text.isNotEmpty &&
            //       idPegawaiController.text.isNotEmpty &&
            //       idobatController.text.isNotEmpty &&
            keluhanController.text.isNotEmpty &&
            diagnosaController.text.isNotEmpty &&
            tglPeriksaController.text.isNotEmpty
        // namaHewanController.text.isNotEmpty &&
        // namaPemilikController.text.isNotEmpty &&
        // namaPegawaiController.text.isNotEmpty &&
        // namaObatController.text.isNotEmpty
        ) {
      final updatedrekammedis = rekamMedis(
        idRekamMedis: 0,
        idHewan: selectedHewan.idHewan ?? 0,
        namaHewan: selectedHewan.namaHewan,
        idPemilik: selectedPemilik.idPemilik,
        namaPemilik: selectedPemilik.namaPemilik ?? '',
        idPegawai: selectedPegawai.idPegawai,
        namaPegawai: selectedPegawai.namaPegawai ?? '',
        idObat: selectedObat.idObat,
        namaObat: selectedObat.namaObat ?? '',
        keluhan: keluhanController.text,
        diagnosa: diagnosaController.text,
        tglPeriksa: tglPeriksaController.text,
        // namaHewan: namaHewanController.text,
        // namaPemilik: namaPemilikController.text,
        // namaPegawai: namaPegawaiController.text,
        // namaObat: namaObatController.text,
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
