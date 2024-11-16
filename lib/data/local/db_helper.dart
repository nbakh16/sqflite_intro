// ignore_for_file: constant_identifier_names

import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/note_model.dart';

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
  Future<bool> addNote({required NoteModel note}) async {
    var db = await getDB();

    int rowsAffected = await db.insert(
      TABLE_NOTE,
      {
        COL_NOTE_TITLE: note.title,
        COL_NOTE_DESC: note.description,
      },
    );

    return rowsAffected > 0;
  }

  //reading
  Future<List<NoteModel>> getAllNotes() async {
    var db = await getDB();

    final rawData = await db.query(TABLE_NOTE);
    List<NoteModel> notes =
        rawData.map((data) => NoteModel.fromJson(data)).toList();

    return notes;
  }

  //update
  void update() {}
}
