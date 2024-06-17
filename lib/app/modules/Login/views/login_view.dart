import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/login/controllers/login_controller.dart';

class LoginView extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());
  final List<String> roles = ['admin', 'pegawai', 'pemilik'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) => loginController.username.value = value,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) => loginController.password.value = value,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Obx(() {
              return DropdownButton<String>(
                value: loginController.selectedRole.value,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    loginController.selectedRole.value = newValue;
                  }
                },
                items: roles.map<DropdownMenuItem<String>>((String role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(role.capitalizeFirst!),
                  );
                }).toList(),
                isExpanded: true,
                hint: Text('Select Role'),
                borderRadius: BorderRadius.circular(10),
                elevation: 2,
                underline: Container(
                  height: 2,
                  color: Colors.grey[300],
                ),
              );
            }),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                loginController.login(loginController.selectedRole.value);
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                minimumSize: Size(200, 50),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8.0), // Ubah nilai sesuai keinginan
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
