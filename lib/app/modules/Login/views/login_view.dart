import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/login/controllers/login_controller.dart';

class LoginView extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());
  final List<String> roles = ['admin', 'pegawai', 'pemilik'];
  final RxBool _obscureText = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        backgroundColor: Color.fromRGBO(179, 110, 61, 1),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFFFFE4C4),
        child: Stack(
          children: [
            // Background image
            // Container(
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage(
            //           'assets/images/logo.webp'), // Ganti dengan path gambar latar belakang
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
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
                        SizedBox(height: 20),
                        TextField(
                          onChanged: (value) =>
                              loginController.username.value = value,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 15),
                        // Password TextField
                        Obx(() {
                          return TextField(
                            onChanged: (value) =>
                                loginController.password.value = value,
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
                        // Role DropdownButton
                        Obx(() {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton<String>(
                              value: loginController.selectedRole.value,
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  loginController.selectedRole.value = newValue;
                                }
                              },
                              items: roles.map<DropdownMenuItem<String>>(
                                (String role) {
                                  return DropdownMenuItem<String>(
                                    value: role,
                                    child: Text(role.capitalizeFirst!),
                                  );
                                },
                              ).toList(),
                              isExpanded: true,
                              hint: Text('Select Role'),
                              underline: Container(
                                height: 2,
                                color: Colors.grey[300],
                              ),
                              dropdownColor: Colors.white,
                              elevation: 2,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          );
                        }),
                        SizedBox(height: 15),
                        // Login Button
                        ElevatedButton(
                          onPressed: () {
                            loginController.login();
                          },
                          child: Text('Login'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromRGBO(179, 110, 61, 1)),
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
                        // Forgot Password Text Button
                        TextButton.icon(
                          onPressed: () {
                            Get.toNamed('/forgotpass');
                            print('Forgot Password tapped');
                          },
                          icon: Icon(
                            Icons.help_outline,
                            color: Colors.blueAccent,
                          ),
                          label: Text(
                            'Forgot Password?',
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
