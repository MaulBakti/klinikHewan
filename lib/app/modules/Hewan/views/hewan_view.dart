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
      body: Column(
        children: [
          Obx(
            () {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (controller.hewanList.isEmpty) {
                return const Center(
                  child: Text('No data available'),
                );
              } else {
                return ListView.builder(
                  itemCount: controller.hewanList.length,
                  itemBuilder: (context, index) {
                    final hewan = controller.hewanList[index];
                    return ListTile(
                      title: Text(hewan.nama_hewan ?? ''),
                      // subtitle: Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text('Jenis Hewan: ${hewan.jenis_hewan ?? ''}'),
                      //     Text(
                      //         'Umur: ${hewan.umur != null ? hewan.umur.toString() : ''}'),
                      //     Text(
                      //         'Berat: ${hewan.berat != null ? hewan.berat.toString() + ' kg' : ''}'),
                      //     Text('Jenis Kelamin: ${hewan.jenis_kelamin ?? ''}'),
                      //   ],
                      // ),
                    );
                  },
                );
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Tambah Data'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              minimumSize: Size(200, 50),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(8.0), // Ubah nilai sesuai keinginan
              ),
            ),
          ),
        ],
      ),
    );
  }
}
