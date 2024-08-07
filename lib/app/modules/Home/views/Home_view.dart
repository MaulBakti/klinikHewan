import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Home/controllers/Home_controller.dart';

class HomeView extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 24),
        backgroundColor: Color.fromRGBO(179, 110, 61, 1),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.search),
          //   onPressed: () {
          //     // Implementasi fungsi pencarian
          //     // Misalnya Get.toNamed('/search');
          //   },
          // ),
          // IconButton(
          //   icon: Icon(Icons.notifications),
          //   onPressed: () {
          //     // Implementasi fungsi notifikasi
          //     // Misalnya Get.toNamed('/notifications');
          //   },
          // ),
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
        color: Color(0xFFFFE4C4),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            if (homeController.role.value == 'admin') {
              return _buildAdminListView();
            } else if (homeController.role.value == 'pegawai') {
              return _buildPegawaiListView();
            } else if (homeController.role.value == 'pemilik') {
              return _buildPemilikListView();
            } else {
              return Center(
                child: Text('Tidak ada data yang ditampilkan untuk peran ini'),
              );
            }
          }),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //     items: const [
      //       BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.favorite), label: 'Favorites'),
      //       BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.message), label: 'Messages'),
      //       BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      //     ],
      //     selectedItemColor: Colors.blue,
      //     unselectedItemColor: Colors.grey,
      //     onTap: (index) {
      //       switch (index) {
      //         case 0:
      //           // Implementasi fungsi pencarian
      //           Get.toNamed('/search');
      //           break;
      //         case 1:
      //           // Implementasi fungsi favorites
      //           Get.toNamed('/favorites');
      //           break;
      //         case 2:
      //           // Implementasi fungsi add
      //           Get.toNamed('/add');
      //           break;
      //         case 3:
      //           // Implementasi fungsi messages
      //           Get.toNamed('/messages');
      //           break;
      //         case 4:
      //           // Implementasi fungsi profile
      //           Get.toNamed('/profile');
      //           break;
      //       }
      //     }),
    );
  }

  Widget _buildAdminListView() {
    return ListView(
      children: [
        _buildListTile(
          title: 'Data Pemilik',
          icon: Icons.business,
          onTap: () {
            Get.toNamed('/pemilik');
          },
        ),
        _buildListTile(
          title: 'Data Pegawai',
          icon: Icons.people,
          onTap: () {
            Get.toNamed('/pegawai');
          },
        ),
        _buildListTile(
          title: 'Data Dokter',
          icon: Icons.medical_services,
          onTap: () {
            Get.toNamed('/dokter');
          },
        ),
        _buildListTile(
          title: 'Data Hewan',
          icon: Icons.pets,
          onTap: () {
            Get.toNamed('/hewan');
          },
        ),
        _buildListTile(
          title: 'Data Obat',
          icon: Icons.local_pharmacy,
          onTap: () {
            Get.toNamed('/obat');
          },
        ),
        _buildListTile(
          title: 'Data Resep',
          icon: Icons.receipt,
          onTap: () {
            Get.toNamed('/resep');
          },
        ),
        _buildListTile(
          title: 'Data Rekam Medis',
          icon: Icons.assignment,
          onTap: () {
            Get.toNamed('/rekam-medis');
          },
        ),
        _buildListTile(
          title: 'Data Appointment',
          icon: Icons.payment,
          onTap: () {
            Get.toNamed('/appointment');
          },
        ),
        _buildListTile(
          title: 'Data Pembayaran',
          icon: Icons.payment,
          onTap: () {
            Get.toNamed('/pembayaran');
          },
        ),
      ],
    );
  }

  Widget _buildPegawaiListView() {
    return ListView(
      children: [
        _buildListTile(
          title: 'Profile',
          icon: Icons.person,
          onTap: () {
            Get.toNamed('/profile-pegawai');
          },
        ),
        _buildListTile(
          title: 'Data Pemilik',
          icon: Icons.person,
          onTap: () {
            Get.toNamed('/pemilik');
          },
        ),
        _buildListTile(
          title: 'Data Dokter',
          icon: Icons.medical_services,
          onTap: () {
            Get.toNamed('/dokter');
          },
        ),
        _buildListTile(
          title: 'Data Appointment',
          icon: Icons.payment,
          onTap: () {
            Get.toNamed('/appointment');
          },
        ),
        _buildListTile(
          title: 'Data Hewan',
          icon: Icons.pets,
          onTap: () {
            Get.toNamed('/hewan');
          },
        ),
        _buildListTile(
          title: 'Data Resep',
          icon: Icons.receipt,
          onTap: () {
            Get.toNamed('/resep');
          },
        ),
        _buildListTile(
          title: 'Data Obat',
          icon: Icons.local_pharmacy,
          onTap: () {
            Get.toNamed('/obat');
          },
        ),
        _buildListTile(
          title: 'Data Rekam Medis',
          icon: Icons.assignment,
          onTap: () {
            Get.toNamed('/rekam-medis');
          },
        ),
        _buildListTile(
          title: 'Data Pembayaran',
          icon: Icons.payment,
          onTap: () {
            Get.toNamed('/pembayaran');
          },
        ),
      ],
    );
  }

  Widget _buildPemilikListView() {
    return ListView(
      children: [
        _buildListTile(
          title: 'Profile',
          icon: Icons.person,
          onTap: () {
            Get.toNamed('/profile-pemilik');
          },
        ),
        // _buildListTile(
        //   title: 'Data Doctor',
        //   icon: Icons.medical_services,
        //   onTap: () {
        //     Get.toNamed('/doctor');
        //   },
        // ),
        _buildListTile(
          title: 'Data Hewan',
          icon: Icons.pets,
          onTap: () {
            Get.toNamed('/hewan');
          },
        ),
        _buildListTile(
          title: 'Data Obat',
          icon: Icons.local_pharmacy,
          onTap: () {
            Get.toNamed('/obat');
          },
        ),
        _buildListTile(
          title: 'Data Resep',
          icon: Icons.receipt,
          onTap: () {
            Get.toNamed('/resep');
          },
        ),
        _buildListTile(
          title: 'Data Rekam Medis',
          icon: Icons.assignment,
          onTap: () {
            Get.toNamed('/rekam-medis');
          },
        ),
        _buildListTile(
          title: 'Data Appointment',
          icon: Icons.payment,
          onTap: () {
            Get.toNamed('/appointment');
          },
        ),
        _buildListTile(
          title: 'Data Pembayaran',
          icon: Icons.payment,
          onTap: () {
            Get.toNamed('/pembayaran');
          },
        ),
      ],
    );
  }

  Widget _buildListTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        splashColor: Color.fromRGBO(179, 110, 61, 1),
        leading: Icon(icon),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward),
        onTap: onTap,
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
