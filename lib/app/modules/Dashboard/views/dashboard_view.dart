import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Login/views/login_view.dart'; // Sesuaikan dengan path yang benar

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Get.offAll(() => LoginView());
    });

    return Scaffold(
      body: Container(
        color: Color(0xFFFFE4C4),
        child: Center(
          child: Image.asset(
            'assets/Images/Logo.png',
            height: 200,
          ),
        ),
      ),
    );
  }
}
