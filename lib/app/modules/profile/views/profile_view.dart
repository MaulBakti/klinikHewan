import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../../Pegawai/models/pegawai.dart';

class ProfileView extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

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
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(() {
          final pegawai = controller.pegawai.value;

          if (pegawai == null) {
            return CircularProgressIndicator(); // Loading state
          }

          // Initialize controllers with existing data
          usernameController.text = pegawai.namaPegawai;
          jabatanController.text = pegawai.jabatan;
          alamatController.text = pegawai.alamat;
          noTelpController.text = pegawai.noTelp;

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
                      'assets/images/logo.webp',
                      height: 100,
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                      ),
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
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _validateAndUpdateProfile(context, pegawai);
                      },
                      child: const Text('Update Profile'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  void _validateAndUpdateProfile(BuildContext context, Pegawai pegawai) {
    if (usernameController.text.isEmpty ||
        alamatController.text.isEmpty ||
        noTelpController.text.isEmpty) {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Semua field harus diisi',
      );
      return;
    }

    String? password = passwordController.text;
    if (password.isNotEmpty && password.length < 6) {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Password harus minimal 6 karakter.',
      );
      return;
    }

    Pegawai updatedPegawai = Pegawai(
      idPegawai: pegawai.idPegawai,
      namaPegawai: usernameController.text,
      password:
          password.isNotEmpty ? password : null, // Include password if provided
      jabatan: jabatanController.text,
      alamat: alamatController.text,
      noTelp: noTelpController.text,
    );

    controller.updatePegawai(updatedPegawai).then((_) {
      Get.snackbar(
        'Success',
        'Profile updated successfully!',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
      Navigator.of(context).pop(); // Close the dialog or screen
    }).catchError((error) {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Failed to update profile: $error',
      );
    });
  }
}
