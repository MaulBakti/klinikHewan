import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pemilik_view.dart';
import '../controllers/pemilik_controller.dart';

class tambahPemilik extends StatefulWidget {
  const tambahPemilik({super.key});

  @override
  State<tambahPemilik> createState() => _tambahPemilikState();
}

class _tambahPemilikState extends State<tambahPemilik> {
  final _formKey = GlobalKey<FormState>();
  final _namaPemilikCtrl = TextEditingController();
  final _alamatCtrl = TextEditingController();
  final _noTelpCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Data',
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
        padding: const EdgeInsets.all(10),
        child: Form(
            key: _formKey,
            child:
            Column(
              children: [
                SizedBox(height: 10,),
                _fieldNamaPemilik("Nama Pemilik",_namaPemilikCtrl,TextInputType.text),
                SizedBox(height: 10,),
                _fieldNamaPemilik("Alamat",_alamatCtrl,TextInputType.text),
                SizedBox(height: 10,),
                _fieldNamaPemilik("No Telp",_noTelpCtrl,TextInputType.text),
                SizedBox(height: 20,),
                _tombolSimpan(),
              ],
            )
        ),
      ),
    );
  }
}
_fieldNamaPemilik(String label, Ctrl, keyboardtext){
  return TextField(
    keyboardType: keyboardtext,
    decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
    controller: Ctrl,
  );
}

_tombolSimpan(){
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
