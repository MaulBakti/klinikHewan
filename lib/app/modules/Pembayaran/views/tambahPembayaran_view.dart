import 'package:flutter/material.dart';

class tambahPembayaran extends StatefulWidget {
  const tambahPembayaran({super.key});

  @override
  State<tambahPembayaran> createState() => _tambahPembayaranState();
}

class _tambahPembayaranState extends State<tambahPembayaran> {
  final _formKey = GlobalKey<FormState>();
  final _rekamMedis = TextEditingController();
  final _tglPembayaran = TextEditingController();
  final _jumlahPembayaran = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Pembayaran',
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
                _fieldPembayaran(
                    "Rekam Medis", _rekamMedis, TextInputType.text),
                SizedBox(height: 15,),
                _fieldPembayaran("Tgl Pembayaran", _tglPembayaran, TextInputType.text),
                SizedBox(height: 15,),
                _fieldPembayaran(
                    "Jumlah", _jumlahPembayaran, TextInputType.text),
                SizedBox(height: 20,),
                _tombolSimpan(),

              ],
            )
        ),
      ),
    );
  }

  _fieldPembayaran(String label, Ctrl, keyboardtext) {
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