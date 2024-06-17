import 'package:flutter/material.dart';
import 'package:klinik_hewan/app/modules/Resep/controllers/detailResep_controller.dart';

class detailResepObat extends StatefulWidget {
  const detailResepObat({super.key});

  @override
  State<detailResepObat> createState() => _detailResepObatState();
}

class _detailResepObatState extends State<detailResepObat> {
  final _formKey = GlobalKey<FormState>();
  final _rekamMedisCtrl = TextEditingController();
  final _obatCtrl = TextEditingController();
  final _jumlahCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Resep Obat',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                _fieldResep("Rekam Medis", _rekamMedisCtrl, TextInputType.text),
                SizedBox(
                  height: 15,
                ),
                _fieldResep("Obat", _obatCtrl, TextInputType.text),
                SizedBox(
                  height: 15,
                ),
                _fieldResep("jumlah", _jumlahCtrl, TextInputType.text),
                SizedBox(
                  height: 20,
                ),
                _tombolUbah(),
                SizedBox(
                  height: 20,
                ),
                _tombolHapus(),
              ],
            )),
      ),
    );
  }

  _fieldResep(String label, Ctrl, keyboardtext) {
    return TextField(
      keyboardType: keyboardtext,
      decoration:
          InputDecoration(labelText: label, border: OutlineInputBorder()),
      controller: Ctrl,
    );
  }

  _tombolHapus() {
    return ElevatedButton(
      onPressed: () {
        //blm diisi
      },
      child: const Text("Simpan"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        minimumSize: Size(200, 50),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(8.0), // Ubah nilai sesuai keinginan
        ),
      ),
    );
  }

  _tombolUbah() {
    return ElevatedButton(
      onPressed: () {
        //blm diisi
      },
      child: const Text("Simpan"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        minimumSize: Size(200, 50),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(8.0), // Ubah nilai sesuai keinginan
        ),
      ),
    );
  }
}
