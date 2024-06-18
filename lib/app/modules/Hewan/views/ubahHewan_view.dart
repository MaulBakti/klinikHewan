import 'package:flutter/material.dart';
import 'package:get/get.dart';

<<<<<<< HEAD
class ubahHewanView extends StatefulWidget {
  const ubahHewanView({super.key});

  @override
  State<ubahHewanView> createState() => _ubahHewanState();
}

class _ubahHewanState extends State<ubahHewanView> {
  final _formKey = GlobalKey<FormState>();
  final _namaHewanCtrl = TextEditingController();
  final _jenisHewanCtrl = TextEditingController();
  final _umurCtrl = TextEditingController();
  final _beratCtrl = TextEditingController();
  final _jenisKelaminCtrl = TextEditingController();
=======
import '../controllers/ubahHewan_controller.dart';

class UbahHewanView extends GetView<UbahhewanController> {
  const UbahHewanView({Key? key}) : super(key: key);

>>>>>>> 7660690e6ea3a02fbd7daabd0cb69a064b01455e
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubah Hewan'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Nama Hewan'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Jenis Hewan'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Usia Hewan'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Berat'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'jenis Kelamin'),
            ),
            SizedBox(height: 20),
            Obx(() => ElevatedButton(
                  onPressed: controller.updateHewan,
                  child: controller.isLoading.value
                      ? CircularProgressIndicator()
                      : Text('Simpan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    minimumSize: Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8.0), // Ubah nilai sesuai keinginan
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
