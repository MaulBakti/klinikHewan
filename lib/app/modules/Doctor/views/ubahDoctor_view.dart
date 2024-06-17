import 'package:flutter/material.dart';
import 'package:klinik_hewan/app/modules/Doctor/controllers/ubahDoctor_controller.dart';

class ubahDoctor extends StatefulWidget {
  const ubahDoctor({super.key});

  @override
  State<ubahDoctor> createState() => _ubahDoctorState();
}

class _ubahDoctorState extends State<ubahDoctor> {
  final _formKey = GlobalKey<FormState>();
  final _namaDoctorCtrl = TextEditingController();
  final _spesialisCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ubah Doctor',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                _fieldNamaDoctor(
                    "Nama Doctor", _namaDoctorCtrl, TextInputType.text),
                SizedBox(
                  height: 15,
                ),
                _fieldNamaDoctor(
                    "Spesialis", _spesialisCtrl, TextInputType.text),
                SizedBox(
                  height: 20,
                ),
                _tombolSimpan(),
              ],
            )),
      ),
    );
  }
}

_fieldNamaDoctor(String label, Ctrl, keyboardtext) {
  return TextField(
    keyboardType: keyboardtext,
    decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
    controller: Ctrl,
  );
}

_tombolSimpan() {
  return ElevatedButton(
    onPressed: () {},
    child: Text("Ubah Data"),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      minimumSize: Size(200, 30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );
}
