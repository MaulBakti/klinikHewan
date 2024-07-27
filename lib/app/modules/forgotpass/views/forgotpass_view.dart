import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/forgotpass_controller.dart';

class ForgotpassView extends GetView<ForgotpassController> {
  const ForgotpassView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RxBool _obscureTextNew = true.obs;
    final RxBool _obscureTextConfirm = true.obs;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
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
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Logo
                        Image.asset(
                          'assets/Images/Logo.jpg',
                          height: 100,
                        ),
                        SizedBox(height: 20),
                        // Username/Telephone TextField
                        TextField(
                          onChanged: (value) {
                            controller.keywords.value = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'Username/Telephone',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                        SizedBox(height: 15),
                        // New Password TextField
                        Obx(() {
                          return TextField(
                            onChanged: (value) =>
                                controller.newPassword.value = value,
                            decoration: InputDecoration(
                              labelText: 'New Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureTextNew.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  _obscureTextNew.value =
                                      !_obscureTextNew.value;
                                },
                              ),
                            ),
                            obscureText: _obscureTextNew.value,
                          );
                        }),
                        SizedBox(height: 15),
                        // Confirm Password TextField
                        Obx(() {
                          return TextField(
                            onChanged: (value) =>
                                controller.confirmPassword.value = value,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureTextConfirm.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  _obscureTextConfirm.value =
                                      !_obscureTextConfirm.value;
                                },
                              ),
                            ),
                            obscureText: _obscureTextConfirm.value,
                          );
                        }),
                        SizedBox(height: 15),
                        // Submit Button
                        ElevatedButton(
                          onPressed: () {
                            // Validasi jika salah satu dari username atau no_telp kosong
                            if (controller.keywords.value.isEmpty) {
                              Get.snackbar(
                                  'Error', 'Username or Telephone is required');
                              return;
                            }
                            controller.resetPassword();
                          },
                          child: Text('Reset'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromRGBO(179, 110, 61, 1)),
                            overlayColor: MaterialStateProperty.all<Color>(
                                Color(0xFFffc26f)),
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
                            'Login?',
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
