import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/detailHewan_controller.dart';

class DetailhewanView extends GetView<DetailhewanController> {
  const DetailhewanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Hewan View'),
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
                    return Column(
                      children: [
                        ListTile(
                          title: Text(hewan.nama_hewan ?? ''),
                        ),
                        ListTile(
                          title:
                              Text('Jenis hewan: ${hewan.jenis_hewan ?? ''}'),
                        ),
                        ListTile(
                          title: Text(
                              'Umur: ${hewan.umur != null ? hewan.umur.toString() : ''}'),
                        ),
                        ListTile(
                          title: Text(
                              'Berat: ${hewan.berat != null ? hewan.berat.toString() + ' kg' : ''}'),
                        ),
                        ListTile(
                          title: Text(
                              'Jenis Kelamin: ${hewan.jenis_kelamin ?? ''}'),
                        ),
                      ],
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
            child: Text('Ubah Data'),
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
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Hapus Data'),
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
