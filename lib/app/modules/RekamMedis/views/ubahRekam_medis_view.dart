import 'package:flutter/material.dart';

class ubahRekamMedis extends StatefulWidget {
  const ubahRekamMedis({super.key});

  @override
  State<ubahRekamMedis> createState() => _ubahRekamMedisState();
}

class _ubahRekamMedisState extends State<ubahRekamMedis> {
  final _formKey = GlobalKey<FormState>();
  final _hewanCtrl = TextEditingController();
  final _pegawaiCtrl = TextEditingController();
  final _obatCtrl = TextEditingController();
  final _keluhanCtrl = TextEditingController();
  final _diagnosaCtrl = TextEditingController();
  final _tglPeriksaCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ubah Data',
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
                _fieldRekamMedis("Nama Hewan",_hewanCtrl,TextInputType.text),
                SizedBox(height: 15,),
                _fieldRekamMedis("Nama Pegawai",_pegawaiCtrl,TextInputType.text),
                SizedBox(height: 15,),
                _fieldRekamMedis("Obat",_obatCtrl,TextInputType.text),
                SizedBox(height: 15,),
                _fieldRekamMedis("Keluhan",_keluhanCtrl,TextInputType.text),
                SizedBox(height: 15,),
                _fieldRekamMedis("Diagnosa",_diagnosaCtrl,TextInputType.text),
                SizedBox(height: 15,),
                _fieldRekamMedis("Tgl Periksa",_tglPeriksaCtrl,TextInputType.text),
                SizedBox(height: 20,),
                _tombolSimpan()
              ],
            )
        ),
      ),
    );
  }
}
_fieldRekamMedis(String label, Ctrl, keyboardtext){
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

