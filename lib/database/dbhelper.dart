import 'package:flutter_uas/models/biodata.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  //inisialisasi beberapa variabel yang dibutuhkan
  final String tableName = 'tableBiodata';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnNim = 'nim';
  final String columnAlamat = 'alamat';
  final String columnJenisKelamin = 'jenisKelamin';
  final String columnDate = 'date';

  DbHelper._internal();
  factory DbHelper() => _instance;

  //cek apakah database ada
  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(
      databasePath,
      'biodata.db',
    );

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  //membuat tabel dan field-fieldnya
  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
        "$columnName TEXT,"
        "$columnNim TEXT,"
        "$columnAlamat TEXT,"
        "$columnJenisKelamin TEXT,"
        "$columnDate TEXT)";
    await db.execute(sql);
  }

  //insert ke database
  Future<int?> saveBiodata(Biodata biodata) async {
    var dbClient = await _db;
    return await dbClient!.insert(
      tableName,
      biodata.toMap(),
    );
  }

  //read database
  Future<List?> getAllBiodata() async {
    var dbClient = await _db;
    var result = await dbClient!.query(
      tableName,
      columns: [
        columnId,
        columnName,
        columnJenisKelamin,
        columnNim,
        columnAlamat,
        columnDate,
      ],
    );

    return result.toList();
  }

  //update database
  Future<int?> updateBiodata(Biodata biodata) async {
    var dbClient = await _db;
    return await dbClient!.update(
      tableName,
      biodata.toMap(),
      where: '$columnId = ?',
      whereArgs: [biodata.id],
    );
  }

  //hapus database
  Future<int?> deleteBiodata(int id) async {
    var dbClient = await _db;
    return await dbClient!.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
