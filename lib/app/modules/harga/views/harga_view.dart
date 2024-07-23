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
