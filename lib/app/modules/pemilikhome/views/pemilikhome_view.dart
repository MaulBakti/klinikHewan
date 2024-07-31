import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/harga/views/harga_view.dart';
import 'package:klinik_hewan/app/modules/profilePemilik/views/profile_pemilik_view.dart';

import '../controllers/pemilikhome_controller.dart';

class PemilikhomeView extends GetView<PemilikhomeController> {
  const PemilikhomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (controller.selectedIndex.value) {
          case 0:
            return _homeView(context);
          case 1:
            //   return TentangView();
            // case 2:
            return HargaView();
          case 2:
            return ProfilePemilikView();
          default:
            return _homeView(context);
        }
      }),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              // BottomNavigationBarItem(icon: Icon(Icons.inbox), label: 'About'),
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

  Widget _homeView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Gold Vet',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
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
        padding: EdgeInsets.all(10.0),
        color: Color(0xFFFFE4C4),
        child: ListView(
          children: [
            SizedBox(height: 30),
            Center(
              child: CarouselSlider(
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
                            'assets/Slider/Slider$i.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(20),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3, // Number of icons per row
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  physics:
                      NeverScrollableScrollPhysics(), // Disable scrolling for GridView
                  children: [
                    _buildIconButton(
                      icon: Icons.medical_services,
                      label: 'Dokter',
                      onPressed: () {
                        Get.toNamed('/dokter');
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
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              child: Center(
                child: Text(
                  'LAYANAN KAMI',
                  style: TextStyle(
                      color: Color.fromRGBO(179, 110, 61, 1),
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              height: 150,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Rata tengah di Row
                  children: [
                    _buildCustomCard(
                        title: 'PEMERIKSAAN UMUM',
                        content:
                            'Pemeriksaan menyeluruh untuk menjaga kesehatan Anabul kesayangan Anda.'),
                    _buildCustomCard(
                        title: 'VAKSINASI',
                        content:
                            'Lindungi Anabul Anda dengan vaksin berkualitas.'),
                    _buildCustomCard(
                        title: 'STERILISASI',
                        content:
                            'Mencegah perkembangbiakan yang tidak dinginkan dan menjaga kesehatan Anabul Anda.'),
                    _buildCustomCard(
                        title: 'OPERASI MINOR',
                        content:
                            'Solusi cepat untuk masalah kesehatan yang memerlukan intervensi medis.'),
                    _buildCustomCard(
                        title: 'OPERASI MAYOR',
                        content:
                            'Penanganan komprehensif yang membutuhkan intervensi bedah oleh tim medis berpengalaman.'),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Rata tengah kolom
                children: [
                  Text(
                    'Jl. Taman Surya Utama No.A1, RT.1/RW.15, Pegadungan,',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Kec. Kalideres, Kota Jakarta Barat, Daerah Khusus ',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Ibukota Jakarta 11830',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 100, // Adjust the width as needed
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Color(0xFFffc26f),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                icon,
                color: Colors.white,
                size: 30,
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
      ),
    );
  }

  Widget _buildCustomCard({
    required String title,
    required String content,
    double height = 800,
  }) {
    return Container(
      width: 200,
      height: height,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(179, 110, 61, 1)),
            ),
            SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
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
                Navigator.of(context).pop();
                _logout();
              },
            ),
          ],
        );
      },
    );
  }

  void _logout() {
    // homeController
    //     .changeRole('admin'); // Ganti dengan peran default setelah logout
    Get.offAllNamed('/dashboard');
  }
}
