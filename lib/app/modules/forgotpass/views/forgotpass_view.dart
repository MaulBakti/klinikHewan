import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/forgotpass_controller.dart';

class ForgotpassView extends GetView<ForgotpassController> {
  const ForgotpassView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ForgotpassView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ForgotpassView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
