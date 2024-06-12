import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pegawai_controller.dart';

class PegawaiView extends GetView<PegawaiController> {
  const PegawaiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Pegawai'),
        centerTitle: true,
      ),
      body: Obx(
        () {
          // Menampilkan loading indicator jika isLoading true
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Jika isLoading false, tampilkan daftar pegawai
          return ListView.builder(
            itemCount: controller.pegawaiList.length,
            itemBuilder: (context, index) {
              final pegawai = controller.pegawaiList[index];
              return ListTile(
                title: Text(pegawai.username ?? ''),
                subtitle: Text(pegawai.jabatan ?? ''),
                // Tambahkan logic untuk menampilkan detail pegawai atau action lainnya
                // saat tile ditekan
                onTap: () {
                  // Implementasi logika saat tile ditekan
                },
              );
            },
          );
        },
      ),
    );
  }
}
