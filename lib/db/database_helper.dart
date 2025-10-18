import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/karyawan.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'penggajian.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE karyawan (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT,
            jabatan TEXT,
            gajiPokok INTEGER,
            tunjangan INTEGER,
            potongan INTEGER,
            totalGaji INTEGER
          )
        ''');
      },
    );
  }

  Future<int> insertKaryawan(Karyawan karyawan) async {
    final db = await database;
    return await db.insert('karyawan', karyawan.toMap());
  }

  Future<List<Karyawan>> getKaryawanList() async {
    final db = await database;
    final maps = await db.query('karyawan');
    return List.generate(maps.length, (i) {
  return Karyawan(
    id: maps[i]['id'] as int?,
    nama: maps[i]['nama'] as String,
    jabatan: maps[i]['jabatan'] as String,
    gajiPokok: maps[i]['gajiPokok'] as int,
    tunjangan: maps[i]['tunjangan'] as int,
    potongan: maps[i]['potongan'] as int,
  );
});
  }

  Future<int> updateKaryawan(Karyawan karyawan) async {
    final db = await database;
    return await db.update(
      'karyawan',
      karyawan.toMap(),
      where: 'id = ?',
      whereArgs: [karyawan.id],
    );
  }

  Future<int> deleteKaryawan(int id) async {
    final db = await database;
    return await db.delete('karyawan', where: 'id = ?', whereArgs: [id]);
  }
}