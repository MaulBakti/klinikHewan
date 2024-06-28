import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/rekam_medis_controller.dart';

class RekamMedisView extends GetView<RekamMedisController> {
  const RekamMedisView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rekam Medis',
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
              // ikon lonceng ditekan
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Obx(() {
            if (controller.data.isEmpty) {
              return const Center(
                child: Text("No data available"),
              );
            }
            return ListView.builder(
              itemCount: controller.data.length,
              itemBuilder: (context, index) {
                final pemilik = controller.data[index];
                return Container(
                  child: ListTile(
                    title: Text("rekamMedis.id_rekam_medis"),
                    onTap: () {
                      // controller.pemilikDetail(pemilik.);
                    },
                  ),
                );
              },
            );
          }),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Tambah Data"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              minimumSize: Size(200, 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
