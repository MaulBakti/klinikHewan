import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/obat_controller.dart';

class ObatView extends GetView<ObatController> {
  const ObatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Obat View'),
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
              } else if (controller.obatList.isEmpty) {
                return const Center(
                  child: Text('No data available'),
                );
              } else {
                return ListView.builder(
                  itemCount: controller.obatList.length,
                  itemBuilder: (context, index) {
                    final obat = controller.obatList[index];
                    return ListTile(
                      title: Text('Nama Obat'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Keterangan: '),
                        ],
                      ),
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
