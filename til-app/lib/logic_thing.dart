import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

class LogicThing {
  static final shared = LogicThing();

  Future<void> openSources(Uri url) async {
    final path = await getApplicationSupportDirectory();

    final filePath = '${path.path}/source.zip';
    final response = await http.get(url);
    await File(filePath).writeAsBytes(response.bodyBytes);

    final inputStream = InputFileStream(filePath);
    final archive = ZipDecoder().decodeBuffer(inputStream);

    final db = await openDatabase(
      '$path/til.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE til (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, value TEXT)');
      },
    );

    for (var file in archive.files) {
      if (file.isFile) {
        final name = file.name.split('/').last;
        file.decompress();
        final content = String.fromCharCodes(file.content);
        await db.transaction((txn) => txn.execute(
            'INSERT INTO til(name, value) VALUES(?,?)', [name, content]));
      }
    }
    await File(filePath).delete();
    await db.close();
  }

  Future<String> getTil() async {
    final path = await getApplicationSupportDirectory();
    final db = await openDatabase(
      '$path/til.db',
    );

    List<Map> list =
        await db.rawQuery('SELECT * FROM til ORDER BY RANDOM() LIMIT 1;');
    db.close();
    return list[0]['value'];
  }
}
