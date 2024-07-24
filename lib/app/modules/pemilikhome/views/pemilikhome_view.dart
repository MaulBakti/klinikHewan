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
        title: const Text('Gold Vet',
            style: TextStyle(color: Colors.white, fontSize: 24)),
        backgroundColor: Color.fromRGBO(179, 110, 61, 1),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        color: Color(0xFFFFE4C4),
        child: ListView(
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
                          'assets/Slider/Slider$i.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 30),
            Container(
              margin: EdgeInsets.only(right: 10.0, left: 10.0),
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

            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
            )
            // Forgot Password Text Button
            // Column(
            //   children: [
            //     TextButton.icon(
            //       onPressed: () {
            //         // Aksi saat tombol ditekan
            //       },
            //       icon: FaIcon(
            //         FontAwesomeIcons.instagram,
            //       ),
            //       label: Text(
            //         'Instagram',
            //         style: TextStyle(
            //           fontWeight: FontWeight.bold,
            //           decoration: TextDecoration.underline,
            //           fontSize: 16,
            //         ),
            //       ),
            //     ),
            //     TextButton.icon(
            //       onPressed: () {
            //         // Aksi saat tombol ditekan
            //       },
            //       icon: FaIcon(
            //         FontAwesomeIcons.youtube,
            //       ),
            //       label: Text(
            //         'YouTube',
            //         style: TextStyle(
            //           fontWeight: FontWeight.bold,
            //           decoration: TextDecoration.underline,
            //           fontSize: 16,
            //         ),
            //       ),
            //     ),
            //     TextButton.icon(
            //       onPressed: () {
            //         // Aksi saat tombol ditekan
            //       },
            //       icon: FaIcon(
            //         FontAwesomeIcons.tiktok,
            //         color: Colors.black,
            //       ),
            //       label: Text(
            //         'TikTok',
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontWeight: FontWeight.bold,
            //           decoration: TextDecoration.underline,
            //           fontSize: 16,
            //         ),
            //       ),
            //     ),
            //     TextButton.icon(
            //       onPressed: () {
            //         // Aksi saat tombol ditekan
            //       },
            //       icon: FaIcon(
            //         FontAwesomeIcons.whatsapp,
            //         color: Colors.green,
            //       ),
            //       label: Text(
            //         'WhatsApp',
            //         style: TextStyle(
            //           color: Colors.green,
            //           fontWeight: FontWeight.bold,
            //           decoration: TextDecoration.underline,
            //           fontSize: 16,
            //         ),
            //       ),
            //     ),
            //   ],
            // )
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
}
