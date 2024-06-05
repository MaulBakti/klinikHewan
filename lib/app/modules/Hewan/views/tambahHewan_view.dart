import 'package:flutter/material.dart';
import 'package:klinik_hewan/app/modules/Hewan/controllers/hewan_controller.dart';

class tambahHewan extends StatefulWidget {
  const tambahHewan({super.key});

  @override
  State<tambahHewan> createState() => _tambahHewanState();
}

class _tambahHewanState extends State<tambahHewan> {
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
          'Tambah Hewan',
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
                _tombolSimpan(),
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

_tombolSimpan(){
  return ElevatedButton(
      onPressed: ()  {
        //blm diisi
      },
      child: const Text("Simpan"));
}


