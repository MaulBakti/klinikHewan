import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/tambahResep_controller.dart';

class TambahresepView extends GetView<TambahresepController> {
  const TambahresepView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Resep'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) => controller.rekamMedis.value = value,
              decoration: InputDecoration(labelText: 'Rekam Medis'),
            ),
            TextField(
              onChanged: (value) => controller.obat.value = value,
              decoration: InputDecoration(labelText: 'Obat'),
            ),
            TextField(
              onChanged: (value) => controller.jumlah.value = value,
              decoration: InputDecoration(labelText: 'Jumlah'),
            ),
            SizedBox(height: 20),
            Obx(() => ElevatedButton(
                  onPressed: controller.createResep,
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
