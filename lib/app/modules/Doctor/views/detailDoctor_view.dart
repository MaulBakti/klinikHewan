import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/detailDoctor_controller.dart';

class DetaildoctorView extends GetView<DetaildoctorController> {
  const DetaildoctorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Doctor View'),
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
              } else if (controller.doctorList.isEmpty) {
                return const Center(
                  child: Text('No data available'),
                );
              } else {
                return ListView.builder(
                  itemCount: controller.doctorList.length,
                  itemBuilder: (context, index) {
                    final doctor = controller.doctorList[index];
                    return Column(
                      children: [
                        ListTile(
                          title: Text('Nama docter: '),
                        ),
                        ListTile(
                          title: Text('Spesialis: '),
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
