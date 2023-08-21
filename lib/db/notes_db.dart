import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:movie_app/model/models.dart';
import 'package:path/path.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

//This is a getter method named database that returns a Future<Database>.
//It allows you to asynchronously get access to the SQLite database instance.
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

//This private method _initDB() takes a filePath as a parameter and returns a Future<Database>.
//It's responsible for creating and opening the SQLite database.
  Future<Database> _initDB(String filePath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTERGER PRIMARY KEY AUTOINCREMENT';
    final textType = '  TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTERGER  NOT NULL';

    await db.execute('''
  CREATE TABLE $tableNotes(
    ${NoteFields.id} $idType,
    ${NoteFields.adult} $boolType,
    ${NoteFields.genreIds} $textType,
    ${NoteFields.originalLanguage} $textType,
    ${NoteFields.originalTitle} $textType,
    ${NoteFields.overview} $textType,
    ${NoteFields.popularity} $integerType,
    ${NoteFields.posterPath} $textType,
    ${NoteFields.releaseDate} $integerType,
    ${NoteFields.title} $textType,
    ${NoteFields.video} $boolType,
    ${NoteFields.voteAverage} $integerType,
    ${NoteFields.voteCount} $integerType,
    ${NoteFields.backdropPath} $textType,
 )
''');
  }

//This method close() is used to close the SQLite database connection.
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
