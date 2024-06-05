import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Pemilik/views/detailPemilik_view.dart';
import 'tambahPemilik_view.dart';
import '../controllers/pemilik_controller.dart';

class PemilikView extends GetView<PemilikController> {
  const PemilikView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pemilik',
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
                    title: Text(pemilik.nama_pemilik.toString()),
                    onTap: () {
                      // controller.pemilikDetail(pemilik.);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => detailPemilik()));
                      // kedetail
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
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => tambahPemilik()));
            },
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
