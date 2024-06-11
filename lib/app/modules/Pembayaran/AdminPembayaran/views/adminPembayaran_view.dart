import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Pembayaran/AdminPembayaran/views/adminDetailPembayaran_view.dart';
import 'package:klinik_hewan/app/modules/Pembayaran/AdminPembayaran/views/adminTambahPembayaran_view.dart';

import '../controllers/adminPembayaran_controller.dart';

class AdminpembayaranView extends GetView<AdminpembayaranController> {
  const AdminpembayaranView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pembayaran',
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
                    title: Text("pembayaran.id_rekam_medis"),
                    onTap: () {
                      // controller.pemilikDetail(pemilik.);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => detailPembayaran()));
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
                  MaterialPageRoute(builder: (context) => tambahPembayaran()));
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
