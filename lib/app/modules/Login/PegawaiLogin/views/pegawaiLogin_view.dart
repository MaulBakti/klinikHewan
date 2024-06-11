import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pegawaiLogin_controller.dart';

class PegawailoginView extends GetView<PegawailoginController> {
  const PegawailoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login View Pegawai'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) => controller.nama_pegawai.value = value,
              decoration: InputDecoration(labelText: 'Nama Pegawai'),
            ),
            TextField(
              onChanged: (value) => controller.password.value = value,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Obx(() => controller.isLoading.value
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: controller.pegawaiLogin,
                    child: Text('Login'),
                  )),
          ],
        ),
      ),
    );
  }
}
