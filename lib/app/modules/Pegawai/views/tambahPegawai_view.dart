import 'package:flutter/material.dart';

class tambahPegawai extends StatefulWidget {
  const tambahPegawai({super.key});

  @override
  State<tambahPegawai> createState() => _tambahPegawaiState();
}

class _tambahPegawaiState extends State<tambahPegawai> {
  final _formKey = GlobalKey<FormState>();
  final _namaPegawaiCtrl = TextEditingController();
  final _jabatanCtrl = TextEditingController();
  final _alamatCtrl = TextEditingController();
  final _noTelpCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pegawai',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Aksi ketika ikon lonceng ditekan
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child:
            Column(
              children: [
                SizedBox(height: 15,),
                _fieldNamaPegawai(
                    "Nama Pegawai", _namaPegawaiCtrl, TextInputType.text),
                SizedBox(height: 15,),
                _fieldNamaPegawai("Jabatan", _jabatanCtrl, TextInputType.text),
                SizedBox(height: 15,),
                _fieldNamaPegawai("Alamat", _alamatCtrl, TextInputType.text),
                SizedBox(height: 15,),
                _fieldNamaPegawai("No Telp", _noTelpCtrl, TextInputType.text),
                SizedBox(height: 20,),
                _tombolSimpan(),

              ],
            )
        ),
      ),
    );
  }

  _fieldNamaPegawai(String label, Ctrl, keyboardtext) {
    return TextField(
      keyboardType: keyboardtext,
      decoration: InputDecoration(
          labelText: label, border: OutlineInputBorder()),
      controller: Ctrl,
    );
  }

  _tombolSimpan() {
    return ElevatedButton(
      onPressed: () {

      },
      child: Text("Simpan Data"),
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
}
