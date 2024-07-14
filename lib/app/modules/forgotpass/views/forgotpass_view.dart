import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/forgotpass_controller.dart';

class ForgotpassView extends GetView<ForgotpassController> {
  const ForgotpassView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ForgotpassView'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 15),
                  TextField(
                    // onChanged: (value) => controller.noTelp.value = value,
                    decoration: InputDecoration(
                      labelText: 'No Telp',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Cari'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(200, 50)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed('/dashboard');
                    },
                    child: Text('Batal'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(200, 50)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
