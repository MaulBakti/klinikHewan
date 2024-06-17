import 'package:flutter/material.dart';
import 'package:klinik_hewan/app/modules/Obat/controllers/obat_controller.dart';

class detailAppoitment extends StatefulWidget {
  const detailAppoitment({super.key});

  @override
  State<detailAppoitment> createState() => _detailAppoitmentState();
}

class _detailAppoitmentState extends State<detailAppoitment> {
  final _formKey = GlobalKey<FormState>();
  final _hewanCtrl = TextEditingController();
  final _dokterCtrl = TextEditingController();
  final _tglAppoitmentCtrl = TextEditingController();
  final _catatanCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Appoitment',
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
                _fieldNamaAppoitment("hewan", _hewanCtrl, TextInputType.text),
                SizedBox(
                  height: 15,
                ),
                _fieldNamaAppoitment("Dokter", _dokterCtrl, TextInputType.text),
                SizedBox(
                  height: 15,
                ),
                _fieldNamaAppoitment("tanggal Appoitment", _tglAppoitmentCtrl,
                    TextInputType.text),
                SizedBox(
                  height: 15,
                ),
                _fieldNamaAppoitment(
                    "Catatan", _catatanCtrl, TextInputType.text),
                SizedBox(
                  height: 20,
                ),
                _tombolubah(),
                SizedBox(
                  height: 20,
                ),
                _tombolhapus(),
              ],
            )),
      ),
    );
  }

  _fieldNamaAppoitment(String label, Ctrl, keyboardtext) {
    return TextField(
      keyboardType: keyboardtext,
      decoration:
          InputDecoration(labelText: label, border: OutlineInputBorder()),
      controller: Ctrl,
    );
  }

  _tombolubah() {
    return ElevatedButton(
      onPressed: () {
        //blm diisi
      },
      child: const Text("Ubah"),
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

  _tombolhapus() {
    return ElevatedButton(
      onPressed: () {
        //blm diisi
      },
      child: const Text("Hapus"),
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
