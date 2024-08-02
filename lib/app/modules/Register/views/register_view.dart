import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RxBool _obscureText = true.obs;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 24),
        backgroundColor: Color.fromRGBO(179, 110, 61, 1),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFFFFE4C4),
        child: Stack(
          children: [
            Center(
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
                        // Logo
                        Image.asset(
                          'assets/Images/Logo.jpg', // Ganti dengan path gambar logo
                          height: 100,
                        ),
                        SizedBox(height: 15),
                        TextField(
                          onChanged: (value) =>
                              controller.username.value = value,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 15),
                        Obx(() {
                          return TextField(
                            onChanged: (value) =>
                                controller.password.value = value,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  _obscureText.value = !_obscureText.value;
                                },
                              ),
                            ),
                            obscureText: _obscureText.value,
                          );
                        }),
                        SizedBox(height: 15),
                        TextField(
                          onChanged: (value) => controller.alamat.value = value,
                          decoration: InputDecoration(
                            labelText: 'Alamat',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          onChanged: (value) => controller.noTelp.value = value,
                          decoration: InputDecoration(
                            labelText: 'No Telp',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () {
                            controller.register();
                          },
                          child: Text('Register'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromRGBO(179, 110, 61, 1)),
                            overlayColor: MaterialStateProperty.all<Color>(
                                Color(0xFFffc26f)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            maximumSize:
                                MaterialStateProperty.all<Size>(Size(200, 50)),
                            minimumSize:
                                MaterialStateProperty.all<Size>(Size(100, 50)),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        // Login Text Button
                        TextButton.icon(
                          onPressed: () {
                            Get.toNamed('/login');
                            print('Login tapped');
                          },
                          icon: Icon(
                            Icons.help_outline,
                            color: Colors.blueAccent,
                          ),
                          label: Text(
                            'Sudah punya akun?',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
