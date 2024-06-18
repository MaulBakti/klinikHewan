import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/tambahAppointment_controller.dart';

class TambahappointmentView extends GetView<TambahappointmentController> {
  const TambahappointmentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Appointment'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) => controller.hewan.value = value,
              decoration: InputDecoration(labelText: 'hewan'),
            ),
            TextField(
              onChanged: (value) => controller.doctor.value = value,
              decoration: InputDecoration(labelText: 'Nama Doctor'),
            ),
            TextField(
              onChanged: (value) => controller.tanggal.value = value,
              decoration: InputDecoration(labelText: 'Tanggal Appointment'),
            ),
            TextField(
              onChanged: (value) => controller.catatan.value = value,
              decoration: InputDecoration(labelText: 'Catatan'),
            ),
            SizedBox(height: 20),
            Obx(() => ElevatedButton(
                  onPressed: controller.createAppointment,
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
