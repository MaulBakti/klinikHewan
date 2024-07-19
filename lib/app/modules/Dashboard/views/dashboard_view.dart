import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Color(0xFFFFE4C4),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.notifications, color: Colors.black),
        //     onPressed: () {
        //       // Implementasi aksi ketika ikon notifikasi ditekan
        //     },
        //   ),
        // ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/dashboard_background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _buildListTile(
                title: 'Login',
                icon: Icons.login,
                onTap: () {
                  Get.toNamed('/login');
                },
              ),
              _buildListTile(
                title: 'Register',
                icon: Icons.app_registration,
                onTap: () {
                  Get.toNamed('/regist');
                },
              ),
              _buildListTile(
                title: 'Settings',
                icon: Icons.settings,
                onTap: () {
                  // Ganti dengan navigasi ke halaman pengaturan
                },
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.favorite), label: 'Favorites'),
      //     BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
      //     BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      //   ],
      //   selectedItemColor: Colors.blue,
      //   unselectedItemColor: Colors.grey,
      // ),
    );
  }

  Widget _buildListTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title),
        leading: Icon(icon),
        trailing: Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }
}
