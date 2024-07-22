import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

import '../controllers/pemilikhome_controller.dart';

class PemilikhomeView extends GetView<PemilikhomeController> {
  const PemilikhomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gold Vet'),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 24),
        backgroundColor: Color.fromRGBO(179, 110, 61, 1),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 30),
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                viewportFraction: 0.8,
              ),
              items: [1, 2, 3].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/Slider/Slider$i.jpg', // Pastikan gambar berada di assets dan namanya sesuai
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 30),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: [
                _buildIconButton(
                  icon: Icons.medical_services,
                  label: 'Doctor',
                  onPressed: () {
                    Get.toNamed('/doctor');
                  },
                ),
                _buildIconButton(
                  icon: Icons.pets,
                  label: 'Hewan',
                  onPressed: () {
                    Get.toNamed('/hewan');
                  },
                ),
                _buildIconButton(
                  icon: Icons.local_pharmacy,
                  label: 'Obat',
                  onPressed: () {
                    Get.toNamed('/obat');
                  },
                ),
                _buildIconButton(
                  icon: Icons.receipt,
                  label: 'Resep',
                  onPressed: () {
                    Get.toNamed('/resep');
                  },
                ),
                _buildIconButton(
                  icon: Icons.assessment,
                  label: 'Rekam Medis',
                  onPressed: () {
                    Get.toNamed('/rekam-medis');
                  },
                ),
                _buildIconButton(
                  icon: Icons.payment,
                  label: 'Appointment',
                  onPressed: () {
                    Get.toNamed('/appointment');
                  },
                ),
                _buildIconButton(
                  icon: Icons.payment,
                  label: 'Pembayaran',
                  onPressed: () {
                    Get.toNamed('/pembayaran');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.inbox), label: 'About'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.price_check), label: 'Harga'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
            currentIndex: controller.selectedIndex.value,
            selectedItemColor: Color(0xFFffc26f),
            unselectedItemColor: Colors.grey,
            onTap: controller.onItemTapped,
          )),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Color(0xFFffc26f),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              icon,
              color: Colors.white,
              size: 40,
            ),
            onPressed: onPressed,
          ),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.black54),
          textAlign: TextAlign.center,
        ),
      ],
    );
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
