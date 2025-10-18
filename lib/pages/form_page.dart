import 'package:flutter/material.dart';
import '../models/karyawan.dart';
import '../db/database_helper.dart';

class FormPage extends StatefulWidget {
  final Karyawan? karyawan;
  final Function refresh;

  FormPage({this.karyawan, required this.refresh});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaCtrl = TextEditingController();
  final _jabatanCtrl = TextEditingController();
  final _gajiCtrl = TextEditingController();
  final _tunjCtrl = TextEditingController();
  final _potCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.karyawan != null) {
      _namaCtrl.text = widget.karyawan!.nama;
      _jabatanCtrl.text = widget.karyawan!.jabatan;
      _gajiCtrl.text = widget.karyawan!.gajiPokok.toString();
      _tunjCtrl.text = widget.karyawan!.tunjangan.toString();
      _potCtrl.text = widget.karyawan!.potongan.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Form Karyawan")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(controller: _namaCtrl, decoration: InputDecoration(labelText: 'Nama')),
              TextFormField(controller: _jabatanCtrl, decoration: InputDecoration(labelText: 'Jabatan')),
              TextFormField(controller: _gajiCtrl, decoration: InputDecoration(labelText: 'Gaji Pokok'), keyboardType: TextInputType.number),
              TextFormField(controller: _tunjCtrl, decoration: InputDecoration(labelText: 'Tunjangan'), keyboardType: TextInputType.number),
              TextFormField(controller: _potCtrl, decoration: InputDecoration(labelText: 'Potongan'), keyboardType: TextInputType.number),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final karyawan = Karyawan(
                    id: widget.karyawan?.id,
                    nama: _namaCtrl.text,
                    jabatan: _jabatanCtrl.text,
                    gajiPokok: int.parse(_gajiCtrl.text),
                    tunjangan: int.parse(_tunjCtrl.text),
                    potongan: int.parse(_potCtrl.text),
                  );
                  if (widget.karyawan == null) {
                    await DatabaseHelper().insertKaryawan(karyawan);
                  } else {
                    await DatabaseHelper().updateKaryawan(karyawan);
                  }
                  widget.refresh();
                  Navigator.pop(context);
                },
                child: Text('Simpan'),
              )
            ],
          ),
        ),
      ),
    );
  }
}