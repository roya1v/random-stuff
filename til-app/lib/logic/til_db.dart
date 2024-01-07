import 'package:sqflite/sqflite.dart';
import 'package:til_app/logic/model.dart';

class TilDb {
  TilDb({required this.path});

  final String path;
  Database? _db;

  Future<void> addNew(Til til) async {
    await (await _getDb()).transaction((txn) => txn.execute(
        'INSERT INTO til(name, category, value) VALUES(?,?,?)',
        [til.name, til.category, til.content]));
  }

  Future<Til> getRandomTil() async {
    List<Map> list = await (await _getDb())
        .rawQuery('SELECT * FROM til ORDER BY RANDOM() LIMIT 1;');
    final item = list[0];
    return Til(
        category: item['category'], name: item['name'], content: item['value']);
  }

  Future<Database> _getDb() async {
    _db ??= await openDatabase(
      '$path/til.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE til (id INTEGER PRIMARY KEY AUTOINCREMENT, category TEXT, name TEXT, value TEXT)');
      },
    );
    return _db!;
  }

  Future<void> close() async {
    await _db?.close();
  }
}
