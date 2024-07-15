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
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Uncomment the following lines if you have a background image
          // Container(
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage(
          //           'assets/images/background.jpg'), // Update with your background image path
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
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
                        'assets/images/logo.webp', // Ganti dengan path gambar logo
                        height: 100,
                      ),
                      SizedBox(height: 20),
                      TextField(
                        onChanged: (value) =>
                            controller.usernameOrTelp.value = value,
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
                                _obscureTextNew.value = !_obscureTextNew.value;
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
                          controller.resetPassword();
                        },
                        child: Text('Reset'),
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
