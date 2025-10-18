import 'package:flutter/material.dart';
import '../models/karyawan.dart';
import '../db/database_helper.dart';
import 'form_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Karyawan> _karyawanList = [];

  @override
  void initState() {
    super.initState();
    _refreshList(); // ambil data saat pertama kali dibuka
  }

  // Ambil data dari database
  void _refreshList() async {
    final data = await DatabaseHelper().getKaryawanList();
    setState(() => _karyawanList = data);
  }

  // Konfirmasi hapus data
  void _confirmDelete(int id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Hapus Data"),
        content: Text("Yakin mau hapus data ini?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Batal"),
          ),
          TextButton(
            onPressed: () async {
              await DatabaseHelper().deleteKaryawan(id);
              Navigator.pop(context);
              _refreshList();
            },
            child: Text("Hapus", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sistem Penggajian Mobile"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: _karyawanList.isEmpty
          ? Center(child: Text("Belum ada data karyawan"))
          : ListView.builder(
              itemCount: _karyawanList.length,
              itemBuilder: (context, index) {
                final k = _karyawanList[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(
                      k.nama,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Jabatan: ${k.jabatan}\n"
                      "Gaji Pokok: Rp${k.gajiPokok}\n"
                      "Tunjangan: Rp${k.tunjangan}\n"
                      "Potongan: Rp${k.potongan}\n"
                      "Total Gaji: Rp${k.totalGaji}",
                    ),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.orange),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => FormPage(
                                  karyawan: k,
                                  refresh: _refreshList,
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _confirmDelete(k.id!),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FormPage(refresh: _refreshList),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
