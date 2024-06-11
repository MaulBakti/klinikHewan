import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/tambahHewan_controller.dart';

class TambahHewanView extends GetView<TambahHewanController> {
  const TambahHewanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Hewan'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) => controller.nama.value = value,
              decoration: InputDecoration(labelText: 'Nama Hewan'),
            ),
            TextField(
              onChanged: (value) => controller.jenis.value = value,
              decoration: InputDecoration(labelText: 'Jenis Hewan'),
            ),
            TextField(
              onChanged: (value) => controller.usia.value = value,
              decoration: InputDecoration(labelText: 'Usia Hewan'),
            ),
            SizedBox(height: 20),
            Obx(() => ElevatedButton(
                  onPressed: controller.createHewan,
                  child: controller.isLoading.value
                      ? CircularProgressIndicator()
                      : Text('Simpan'),
                )),
          ],
        ),
      ),
    );
  }
}
