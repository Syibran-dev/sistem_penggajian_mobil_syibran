import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'pages/home_page.dart';

void main() async {
  // Inisialisasi Flutter binding dulu
  WidgetsFlutterBinding.ensureInitialized();

  // 🧠 Tambahan penting biar SQLite bisa jalan di Windows:
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}
