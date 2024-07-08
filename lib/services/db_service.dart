import 'package:black_box/data/sql_on_create.dart';
import 'package:black_box/data/typedefs.dart';
import 'package:black_box/models/item.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DbService {
  // Singleton
  static final DbService _instance = DbService._internal();
  factory DbService() => _instance;
  DbService._internal() {
    init();
  }

  late Future<Database> _dbFuture;
  late Database _db;

  Future<Database> getDb() async {
    await _dbFuture;
    return _db;
  }

  void init() async {
    print("Initializing database");
    _dbFuture = openDatabase(
      'database.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute(sqlOnCreate);
        print('Created database');
      },
    );
    _dbFuture.onError((e, st) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: st);
      throw "Failed to initialize database";
    });
    _db = await _dbFuture;
    print('Database initialized');
  }

  Future<List<Item>> loadItems() async {
    await _dbFuture;
    final SqlRows items = await _db.query('items');
    return items.map((item) => Item.fromJson(item)).toList();
  }

  Future<void> saveItem(Item item) async {
    await _dbFuture;
    final items =
        await _db.query('items', where: 'id = ?', whereArgs: [item.id]);
    if (items.isNotEmpty) {
      await _db.update('items', item.toJson(),
          where: 'id = ?', whereArgs: [item.id]);
    } else {
      await _db.insert('items', item.toJson());
    }
  }

  Future<bool> isIdAvailable(String id) async {
    await _dbFuture;
    final SqlRows result =
        await _db.query('items', where: 'id = ?', whereArgs: [id]);
    return result.isEmpty;
  }
}
