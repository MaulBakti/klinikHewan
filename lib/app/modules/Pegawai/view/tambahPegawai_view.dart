import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/tambahPegawai_controller.dart';

class TambahpegawaiView extends GetView<TambahpegawaiController> {
  const TambahpegawaiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pegawai'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) => controller.username.value = value,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              onChanged: (value) => controller.password.value = value,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            TextField(
              onChanged: (value) => controller.jabatan.value = value,
              decoration: InputDecoration(labelText: 'Jabatan'),
            ),
            TextField(
              onChanged: (value) => controller.alamat.value = value,
              decoration: InputDecoration(labelText: 'Alamat'),
            ),
            TextField(
              onChanged: (value) => controller.noTelp.value = value,
              decoration: InputDecoration(labelText: 'No Telp'),
            ),
            SizedBox(height: 20),
            Obx(() => ElevatedButton(
                  onPressed: controller.createPegawai,
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
