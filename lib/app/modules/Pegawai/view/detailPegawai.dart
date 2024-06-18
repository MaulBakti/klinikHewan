import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/detailPegawai_controller.dart';

class DetailpegawaiView extends GetView<DetailpegawaiController> {
  const DetailpegawaiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pegawai'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Obx(
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
                  return Column(
                    children: [
                      ListTile(
                        title: Text(pegawai.username ?? ''),
                      ),
                      ListTile(
                        title: Text('Password: '),
                      ),
                      ListTile(
                        title: Text('Jabatan: '),
                      ),
                      ListTile(
                        title: Text('Alamat: '),
                      ),
                      ListTile(
                        title: Text('bo Telp: '),
                      )
                    ],
                  );
                },
              );
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
            child: Text('hapus Data'),
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
