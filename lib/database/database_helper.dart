import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

final String iD = 'id';

// database table examiner
final String tableQuote = 'quote';
final String columnText = 'text';

class QuoteDB {
  String text;

  QuoteDB({
    this.text,
  });

  // convenience constructor to create a Word object
  QuoteDB.fromMap(Map<String, dynamic> map) {
    text = map[columnText];
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{columnText: text};
    return map;
  }

  Map<String, dynamic> toJson() => {
        "text": text == null ? null : text,
      };
}

// singleton class to manage the database
class DatabaseHelper {
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableQuote(
        $iD INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnText TEXT NOT NULL
    )''');
  }

  Future<int> insertQuote(QuoteDB quoteDB) async {
    Database db = await database;
    int id = await db.insert(
      tableQuote,
      quoteDB.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<QuoteDB>> getAllQuote() async {
    Database db = await database;
    List<Map> maps = await db.query(tableQuote, columns: [iD, columnText]);

    if (maps.length > 0) {
      List<QuoteDB> quote = [];
      maps.forEach((map) => quote.add(QuoteDB.fromMap(map)));
      return quote;
    }
    return null;
  }

  Future<String> queryQuote(String id) async {
    Database db = await database;
    var dataText = await db.query(tableQuote, where: 'id = ?', whereArgs: [id]);
    print('QueryData= $dataText');
    return dataText.toString();
  }

  deleteAll() async {
    Database db = await database;
    db.rawDelete("DELETE FROM quote");
    print('deletion successfull');
  }

  Future<bool> deleteQuote(int id) async {
    Database db = await database;
    int res = await db.rawDelete('DELETE FROM quote WHERE id = ?', [id]);
    return res > 0 ? true : false;
  }
}
