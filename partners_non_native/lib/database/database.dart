import 'package:flutter/material.dart';
import 'package:partners_non_native/models/partner.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Database? _db;
  static Future<void> getDbConnection() async {
    if (_db != null) {
      return;
    }
    _db = await _initDatabase();
  }

  static Future _initDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    _db = await openDatabase(
      join(await getDatabasesPath(), 'partners.db'),
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE partners(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            address TEXT,
            phoneNo TEXT,
            email TEXT,
            ownerPhoneNo TEXT
          )
        ''');
      },
    );
    return _db;
  }

  static Future<int> addPartner(Partner partner) async {
    return await _db!.insert('partners', partner.toMap());
  }

  static Future<List<Partner>> getPartners() async {
    final List<Map<String, dynamic>> maps = await _db!.query('partners');
    return List.generate(
      maps.length,
      (index) => Partner(
        id: maps[index]['id'],
        name: maps[index]['name'],
        address: maps[index]['address'],
        phoneNo: maps[index]['phoneNo'],
        email: maps[index]['email'],
        ownerPhoneNo: maps[index]['ownerPhoneNo'],
      ),
    );
  }

  static Future<int> updatePartner(Partner partner) async {
    return await _db!.update(
      'partners',
      partner.toMap(),
      where: 'id = ?',
      whereArgs: [partner.id],
    );
  }

  static Future<int> deletePartner(int id) async {
    return await _db!.delete(
      'partners',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
