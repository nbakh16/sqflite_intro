// ignore_for_file: constant_identifier_names

import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  //singleton
  DBHelper._();
  static final DBHelper getInstance = DBHelper._();

  //table note
  static const String TABLE_NOTE = 'note';
  static const String COL_NOTE_SERIAL = 's_no';
  static const String COL_NOTE_TITLE = 'title';
  static const String COL_NOTE_DESC = 'description';

  Database? myDB;

  //db Open(Create if not exist)
  Future<Database> getDB() async {
    myDB ??= await openDB();
    return myDB!;
  }

  Future<Database> openDB() async {
    final Directory appDocDirectory = await getApplicationDocumentsDirectory();

    final dbPath = join(appDocDirectory.path, 'note.db');

    return await openDatabase(
      dbPath,
      onCreate: (db, version) {
        //all tables
        db.execute(
          """create table $TABLE_NOTE (
          $COL_NOTE_SERIAL integer primary key autoincrement,
          $COL_NOTE_TITLE text,
          $COL_NOTE_DESC text)    
          """,
        );
      },
      version: 1,
    );
  }

  ///========== Queries ==========
  //insertion
  Future<bool> addNote({required String title, required String desc}) async {
    var db = await getDB();

    int rowsAffected = await db.insert(
      TABLE_NOTE,
      {
        COL_NOTE_TITLE: title,
        COL_NOTE_DESC: desc,
      },
    );

    return rowsAffected > 0;
  }

  //reading
  Future<List<Map<String, Object?>>> getAllNotes() async {
    var db = await getDB();

    List<Map<String, Object?>> data = await db.query(TABLE_NOTE);
    return data;
  }
}
