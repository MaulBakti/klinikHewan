import 'package:flutter/material.dart';
import 'package:klinik_hewan/app/modules/Hewan/controllers/hewan_controller.dart';

class detailHewan extends StatefulWidget {
  const detailHewan({super.key});

  @override
  State<detailHewan> createState() => _detailHewanState();
}

class _detailHewanState extends State<detailHewan> {
  final _formKey = GlobalKey<FormState>();
  final _namaHewanCtrl = TextEditingController();
  final _jenisHewanCtrl = TextEditingController();
  final _umurCtrl = TextEditingController();
  final _beratCtrl = TextEditingController();
  final _jenisKelaminCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ubah Hewan',
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
                _fieldNamaHewan("Nama Hewan",_namaHewanCtrl,TextInputType.text),
                SizedBox(height: 15,),
                _fieldNamaHewan("Jenis Hewan",_jenisHewanCtrl,TextInputType.text),
                SizedBox(height: 15,),
                _fieldNamaHewan("Umur",_umurCtrl,TextInputType.text),
                SizedBox(height: 15,),
                _fieldNamaHewan("Berat",_beratCtrl,TextInputType.text),
                SizedBox(height: 15,),
                _fieldNamaHewan("Jenis Kelamin",_jenisKelaminCtrl,TextInputType.text),
                SizedBox(height: 20,),
                _tombolUbah(),
                SizedBox(height: 20,),
                _tombolHapus()
              ],
            )
        ),
      ),
    );
  }
}

_fieldNamaHewan(String label, Ctrl, keyboardtext){
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

_tombolHapus() {
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


