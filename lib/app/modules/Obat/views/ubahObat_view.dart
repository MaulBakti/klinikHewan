import 'package:flutter/material.dart';
import 'package:klinik_hewan/app/modules/Obat/controllers/obat_controller.dart';

class ubahObat extends StatefulWidget {
  const ubahObat({super.key});

  @override
  State<ubahObat> createState() => _ubahObatState();
}

class _ubahObatState extends State<ubahObat> {
  final _formKey = GlobalKey<FormState>();
  final _namaObatCtrl = TextEditingController();
  final _keteranganCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ubah Obat',
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
                _fieldNamaObat("Nama Obat", _namaObatCtrl, TextInputType.text),
                SizedBox(
                  height: 15,
                ),
                _fieldNamaObat(
                    "Jenis Obat", _keteranganCtrl, TextInputType.text),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 20,
                ),
                _tombolSimpan(),
              ],
            )),
      ),
    );
  }

  _fieldNamaObat(String label, Ctrl, keyboardtext) {
    return TextField(
      keyboardType: keyboardtext,
      decoration:
          InputDecoration(labelText: label, border: OutlineInputBorder()),
      controller: Ctrl,
    );
  }

  _tombolSimpan() {
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
