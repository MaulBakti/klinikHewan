import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Hewan/views/tambahHewan_view.dart';

import '../controllers/hewan_controller.dart';

class HewanView extends GetView<HewanController> {
  const HewanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hewan',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Aksi ketika ikon lonceng ditekan
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Obx(() {
            if (controller.listData.isEmpty) {
              return Center(
                child: Text('Data tidak tersedia'),
              );
            }

            return ListView.builder(
              itemCount: controller.listData.length,
              itemBuilder: (context, index) {
                final hewan = controller.listData[index];
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(hewan.name),
                    onTap: () {
                      // Aksi ketika item daftar ditekan
                    },
                  ),
                );
              },
            );

          }),
          ElevatedButton(

              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => tambahHewan()));
              },
              child: Text("Tambah Data")),
        ],
      ),
    );
  }
}
