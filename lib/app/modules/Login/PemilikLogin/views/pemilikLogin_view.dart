import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pemilikLogin_controller.dart';

class PemilikloginView extends GetView<PemilikloginController> {
  const PemilikloginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login View Pemilik'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) => controller.nama_pemilik.value = value,
              decoration: InputDecoration(labelText: 'Nama Pemilik'),
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
                    onPressed: controller.pemilikLogin,
                    child: Text('Login'),
                  )),
          ],
        ),
      ),
    );
  }
}
