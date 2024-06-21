import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Home/controllers/Home_controller.dart';

class homeView extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implementasi fungsi pencarian
              // Misalnya Get.toNamed('/search');
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Implementasi fungsi notifikasi
              // Misalnya Get.toNamed('/notifications');
            },
          ),
          // _buildProfileAvatar(context),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
      body: Padding(
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
              child: Text('No data to display for this role'),
            );
          }
        }),
      ),
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
          title: 'Data Doctor',
          icon: Icons.medical_services,
          onTap: () {
            Get.toNamed('/doctor');
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

  Widget _buildPegawaiListView() {
    return ListView(
      children: [
        // _buildListTile(
        //   title: 'Data Pegawai',
        //   icon: Icons.people,
        //   onTap: () {
        //     Get.toNamed('/pegawai');
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
      ],
    );
  }

  Widget _buildPemilikListView() {
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
          title: 'Data Hewan',
          icon: Icons.business,
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

  Widget _buildListTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }

  // Widget _buildProfileAvatar(BuildContext context) {
  //   return GestureDetector(
  //     onTap: () {
  //       // Implementasi aksi ketika avatar profil diklik
  //       // Misalnya Get.toNamed('/profile');
  //     },
  //     child: CircleAvatar(
  //       backgroundImage: AssetImage(
  //           'assets/images/avatar.png'), // Ganti dengan gambar profil yang sesuai
  //       radius: 20,
  //     ),
  //   );
  // }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Logout"),
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
    Get.offAllNamed('/dashboard');
  }
}
