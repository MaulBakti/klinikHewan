import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/ubahDoctor_controller.dart';

class UbahdoctorView extends GetView<UbahdoctorController> {
  const UbahdoctorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubah Doctor'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) => controller.namaDoctor.value = value,
              decoration: InputDecoration(labelText: 'Nama Doctor'),
            ),
            TextField(
              onChanged: (value) => controller.spesialis.value = value,
              decoration: InputDecoration(labelText: 'Spesialis'),
            ),
            SizedBox(height: 20),
            Obx(() => ElevatedButton(
                  onPressed: controller.updateDoctor,
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
