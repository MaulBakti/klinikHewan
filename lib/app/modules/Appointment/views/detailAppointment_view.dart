import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/detailAppointment_controller.dart';

class DetailappointmentView extends GetView<DetailappointmentController> {
  const DetailappointmentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appoitment View'),
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
              } else if (controller.appointmenList.isEmpty) {
                return const Center(
                  child: Text('No data available'),
                );
              } else {
                return ListView.builder(
                  itemCount: controller.appointmenList.length,
                  itemBuilder: (context, index) {
                    final appoitment = controller.appointmenList[index];
                    return Column(
                      children: [
                        ListTile(
                          title: Text('Hewan'),
                        ),
                        ListTile(
                          title: Text('Dokter: '),
                        ),
                        ListTile(
                          title: Text('Tanggal: '),
                        ),
                        ListTile(
                          title: Text('Catatan: '),
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
