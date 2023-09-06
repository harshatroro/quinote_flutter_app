import 'package:path/path.dart';
import 'package:quinote_flutter_app/models/note.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseRepository {
  Database? _database;

  Future<Database> get database async {
    if(_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      create table todoTable ( 
        id integer primary key autoincrement, 
        heading text not null,
        body text not null,
        isPinned boolean not null,
      )
    ''');
  }

  Future<int> insertNote(Note note) async {
    final db = await database;
    return await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Note>> notes() async {
    final db = await database;
    final List<Map<String,dynamic>> maps = await db.query('notes');
    return List.generate(maps.length, (i) => Note.fromJson(maps[i]));
  }

  Future<int> updateNote(Note note) async {
    final db = await database;
    return await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );

    // Future<int> deleteNote(int id) async {
    //   final db = await database;
    //   return await db.delete(
    //     'notes',
    //     where: 'id = ?',
    //     whereArgs: [id],
    //   );
    // }
  }
}