import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_pemilik_controller.dart';
import '../../Pemilik/models/pemilik.dart';

class ProfilePemilikView extends StatelessWidget {
  final ProfilePemilikController controller =
      Get.put(ProfilePemilikController());

  // Declare the controllers here
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController jabatanController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController noTelpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile',
            style: TextStyle(color: Colors.white, fontSize: 24)),
        backgroundColor: Color.fromRGBO(179, 110, 61, 1),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFFFFE4C4),
        child: Center(
          child: Obx(() {
            final pemilik = controller.pemilik.value;

            if (pemilik == null) {
              return CircularProgressIndicator(); // Loading state
            }

            // Initialize controllers with existing data
            usernameController.text = pemilik.namaPemilik;
            jabatanController.text = pemilik.jabatan;
            alamatController.text = pemilik.alamat;
            noTelpController.text = pemilik.noTelp;

            return Padding(
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
                      Image.asset(
                        'assets/images/Logo.png',
                        height: 100,
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: jabatanController,
                        decoration: InputDecoration(
                          labelText: 'Jabatan',
                          border: OutlineInputBorder(),
                        ),
                        readOnly: true,
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: alamatController,
                        decoration: InputDecoration(
                          labelText: 'Alamat',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: noTelpController,
                        decoration: InputDecoration(
                          labelText: 'No Telp',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          _validateAndUpdateProfile(context, pemilik);
                        },
                        child: const Text('Update Profile'),
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
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          _showLogoutDialog(context);
                        },
                        child: const Text('Log Out'),
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
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  void _validateAndUpdateProfile(BuildContext context, Pemilik pemilik) {
    if (usernameController.text.isEmpty ||
        alamatController.text.isEmpty ||
        noTelpController.text.isEmpty) {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Semua field harus diisi',
        backgroundColor: Colors.red,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
      );
      return;
    }

    String password = passwordController.text;
    if (password.isNotEmpty && password.length < 6) {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Password harus minimal 6 karakter.',
        backgroundColor: Colors.red,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
      );
      return;
    }

    Pemilik updatePemilik = Pemilik(
      idPemilik: pemilik.idPemilik,
      namaPemilik: usernameController.text,
      password: password.isNotEmpty ? password : pemilik.password ?? '',
      jabatan: jabatanController.text,
      alamat: alamatController.text,
      noTelp: noTelpController.text,
    );

    controller.updatePemilik(updatePemilik).then((_) {
      Get.defaultDialog(
        title: 'Success',
        middleText: 'Profile updated successfully!',
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: Colors.green,
      );
      Navigator.of(context).pop(); // Close the dialog or screen
    }).catchError((error) {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Failed to update profile: $error',
        backgroundColor: Colors.red,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
      );
    });
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFFFE4C4),
          title: const Text("Logout"),
          content: const Text("Apakah Anda yakin ingin logout?"),
          actions: [
            TextButton(
              child: const Text("Batal"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(179, 110, 61, 1)),
                overlayColor:
                    MaterialStateProperty.all<Color>(Color(0xFFffc26f)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                maximumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                minimumSize: MaterialStateProperty.all<Size>(Size(100, 50)),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(
              width: 10,
            ),
            TextButton(
              child: const Text("Logout"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(179, 110, 61, 1)),
                overlayColor:
                    MaterialStateProperty.all<Color>(Color(0xFFffc26f)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                maximumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                minimumSize: MaterialStateProperty.all<Size>(Size(100, 50)),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              onPressed: () {
                Get.offAllNamed('/login');
              },
            ),
          ],
        );
      },
    );
  }
}
