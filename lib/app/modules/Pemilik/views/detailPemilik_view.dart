import 'package:flutter/material.dart';

class detailPemilik extends StatefulWidget {
  const detailPemilik({super.key});

  @override
  State<detailPemilik> createState() => _detailPemilikState();
}

class _detailPemilikState extends State<detailPemilik> {
  final _formKey = GlobalKey<FormState>();
  final _namaPemilikCtrl = TextEditingController();
  final _alamatCtrl = TextEditingController();
  final _noTelpCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pemilik',
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
                _fieldNamaPemilik("Nama Pemilik",_namaPemilikCtrl,TextInputType.text),
                SizedBox(height: 15,),
                _fieldNamaPemilik("Alamat",_alamatCtrl,TextInputType.text),
                SizedBox(height: 15,),
                _fieldNamaPemilik("No Telp",_noTelpCtrl,TextInputType.text),
                SizedBox(height: 20,),
                _tombolUbah(),
                SizedBox(height: 20,),
                _tombolHapus(),
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

_tombolUbah(){
  return ElevatedButton(
    onPressed: () {

    },
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

_tombolHapus(){
  return ElevatedButton(
    onPressed: () {

    },
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
