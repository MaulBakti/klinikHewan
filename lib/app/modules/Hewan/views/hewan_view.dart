import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/hewan_controller.dart';

class HewanView extends GetView<HewanController> {
  const HewanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hewan View'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Hewan View is working'),
      ),
    );
  }
}
