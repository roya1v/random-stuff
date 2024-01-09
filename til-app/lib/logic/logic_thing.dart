import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:til_app/logic/model.dart';
import 'package:til_app/logic/til_db.dart';

class LogicThing {
  static final shared = LogicThing();

  Future<void> openSources(Uri url) async {
    final downloadLink = _getGithubDownloadLink(url);

    final path = await getApplicationSupportDirectory();

    final filePath = '${path.path}/source.zip';
    final response = await http.get(downloadLink);
    await File(filePath).writeAsBytes(response.bodyBytes);

    final inputStream = InputFileStream(filePath);
    final archive = ZipDecoder().decodeBuffer(inputStream);

    final db = TilDb(path: '${path.path}/til.db');

    for (var file in archive.files) {
      if (file.isFile) {
        final pathComponents = file.name.split('/');
        final name = pathComponents.last;
        final category = pathComponents[pathComponents.length - 2];
        file.decompress();
        final content = String.fromCharCodes(file.content);
        await db.addNew(Til(category: category, name: name, content: content));
      }
    }
    await File(filePath).delete();
    await db.close();
  }

  Future<Til> getTil() async {
    final path = await getApplicationSupportDirectory();

    final db = TilDb(path: '${path.path}/til.db');
    final til = await db.getRandomTil();
    await db.close();
    return til;
  }

  Uri _getGithubDownloadLink(Uri originalLink) {
    final author =
        originalLink.pathSegments[originalLink.pathSegments.length - 2];
    final repo = originalLink.pathSegments.last;

    // TODO: What if branch isn't main?
    return Uri.parse(
        'https://github.com/$author/$repo/archive/refs/heads/master.zip');
  }
}
