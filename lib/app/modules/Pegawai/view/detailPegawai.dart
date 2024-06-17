import 'package:flutter/material.dart';
import 'package:klinik_hewan/app/modules/Hewan/controllers/hewan_controller.dart';

class detailPegawai extends StatefulWidget {
  const detailPegawai({super.key});

  @override
  State<detailPegawai> createState() => _detailPegawaiState();
}

class _detailPegawaiState extends State<detailPegawai> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _jabatanCtrl = TextEditingController();
  final _alamatCtrl = TextEditingController();
  final _noTelpCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Pegawai',
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
                _fieldNamaPegawai(
                    "Username", _usernameCtrl, TextInputType.text),
                SizedBox(
                  height: 15,
                ),
                _fieldNamaPegawai(
                    "password", _passwordCtrl, TextInputType.text),
                SizedBox(
                  height: 15,
                ),
                _fieldNamaPegawai("Jabatan", _jabatanCtrl, TextInputType.text),
                SizedBox(
                  height: 15,
                ),
                _fieldNamaPegawai("Alamat", _alamatCtrl, TextInputType.text),
                SizedBox(
                  height: 15,
                ),
                _fieldNamaPegawai("No Telp", _noTelpCtrl, TextInputType.text),
                SizedBox(
                  height: 20,
                ),
                _tombolUbah(),
                SizedBox(
                  height: 20,
                ),
                _tombolHapus()
              ],
            )),
      ),
    );
  }
}

_fieldNamaPegawai(String label, Ctrl, keyboardtext) {
  return TextField(
    keyboardType: keyboardtext,
    decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
    controller: Ctrl,
  );
}

_tombolUbah() {
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

_tombolHapus() {
  return ElevatedButton(
    onPressed: () {},
    child: Text("hapus Data"),
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
