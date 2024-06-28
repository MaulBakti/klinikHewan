import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/resep_controller.dart';

class ResepView extends GetView<ResepController> {
  const ResepView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resep View'),
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
              } else if (controller.resepList.isEmpty) {
                return const Center(
                  child: Text('No data available'),
                );
              } else {
                return ListView.builder(
                  itemCount: controller.resepList.length,
                  itemBuilder: (context, index) {
                    final resep = controller.resepList[index];
                    return ListTile(
                      title: Text('Rekam Medis'),
                      // subtitle: Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text('Obat: '),
                      //     Text('Jumlah Obat: '),
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
