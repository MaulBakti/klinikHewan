import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tentang_controller.dart';

class TentangView extends GetView<TentangController> {
  const TentangView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TentangView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TentangView is working',
          style: TextStyle(fontSize: 20),
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
              overlayColor: MaterialStateProperty.all<Color>(Color(0xFFffc26f)),
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
              overlayColor: MaterialStateProperty.all<Color>(Color(0xFFffc26f)),
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
