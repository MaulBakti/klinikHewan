import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/ubahPegawai_controller.dart';

class UbahpegawaiView extends GetView<UbahpegawaiController> {
  const UbahpegawaiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubah Pegawai'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Password'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Jabatan'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Alamat'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'No Telp'),
            ),
            SizedBox(height: 20),
            Obx(() => ElevatedButton(
                  onPressed: controller.updatePegawai,
                  child: controller.isLoading.value
                      ? CircularProgressIndicator()
                      : Text('Simpan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    minimumSize: Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8.0), // Ubah nilai sesuai keinginan
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
