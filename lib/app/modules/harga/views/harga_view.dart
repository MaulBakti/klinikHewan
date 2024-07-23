import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/harga_controller.dart';

class HargaView extends GetView<HargaController> {
  const HargaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Harga',
            style: TextStyle(color: Colors.white, fontSize: 24)),
        backgroundColor: Color.fromRGBO(179, 110, 61, 1),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildImageCard('assets/Katalog/Katalog.jpg'),
            _buildImageCard('assets/Katalog/Katalog2.jpg'),
            _buildImageCard('assets/Katalog/Katalog3.jpg'),
            _buildImageCard('assets/Katalog/Katalog4.jpg'),
            _buildImageCard('assets/Katalog/Katalog5.jpg'),
            _buildImageCard('assets/Katalog/Katalog6.jpg'),
            _buildImageCard('assets/Katalog/Katalog7.jpg'),
            _buildImageCard('assets/Katalog/Katalog8.jpg'),
            _buildImageCard('assets/Katalog/Katalog9.jpg'),
            _buildImageCard('assets/Katalog/Katalog10.jpg'),
            _buildImageCard('assets/Katalog/Katalog11.jpg'),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCard(String imagePath) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        height: 300,
        width: double.infinity,
        child: Image.asset(imagePath, fit: BoxFit.contain),
      ),
    );
  }
}

void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Color(0xFFFFE4C4),
        title: const Text("Logout"),
        content: const Text("Apakah Anda yakin ingin logout?"),
        actions: [
          TextButton(
            child: const Text("Batal"),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Color.fromRGBO(179, 110, 61, 1)),
              overlayColor: MaterialStateProperty.all(Color(0xFFffc26f)),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              )),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          SizedBox(width: 10),
          TextButton(
            child: const Text("Logout"),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Color.fromRGBO(179, 110, 61, 1)),
              overlayColor: MaterialStateProperty.all(Color(0xFFffc26f)),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              )),
            ),
            onPressed: () => Get.offAllNamed('/login'),
          ),
        ],
      );
    },
  );
}
