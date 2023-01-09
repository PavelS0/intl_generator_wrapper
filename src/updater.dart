

import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;

class Updater {
  final Directory msg;
  List<String> translatedNames = [];
  String? mainName;
  late Map<String, dynamic> mainJson;
  late Iterable<String> mainKeys;
  static JsonEncoder encoder = JsonEncoder.withIndent('  ');

  Updater(this.msg);

  Future<void> upd() async {
    await scan();
    if (mainName != null && translatedNames.isNotEmpty) {
      final mainFile = File(mainName!);
      mainJson =
          json.decode(await mainFile.readAsString()) as Map<String, dynamic>;
      mainKeys = mainJson.keys.where((e) => e[0] != '@');

      for (var n in translatedNames) {
        final f = File(n);
        final j = json.decode(await f.readAsString()) as Map<String, dynamic>;
        final loc = j['@@locale'];
        final base = p.basename(f.path);
        print('Обработка $loc ($base)');

        final added = _addCmp(j);
        final addedCnt = added.length;
        final addedStr = added.join(', ');
        final removed = _removed(j);
        final removedStr = removed.join(', ');
        print('Добавлено $addedCnt записей ($addedStr)');
        if (removed.isNotEmpty)
          print('В исходном файле были удалены следующие ключи: $removedStr');

        await f.copy(p.join(
          p.dirname(f.path),
          p.basename(f.path) + '.bak',
        ));
        await f.writeAsString(encoder.convert(j));
      }
    } else {
      print('Не создан основной файл перевода, или нет переведенных файлов');
    }
  }

  Future<void> scan() async {
    translatedNames = <String>[];
    await for (final e in msg.list()) {
      if (p.basename(e.path) == 'intl_messages.arb') {
        mainName = e.path;
      } else if (p.extension(e.path) == '.arb') {
        translatedNames.add(e.path);
      }
    }
  }

  List<String> _addCmp(Map<String, dynamic> j) {
    final added = <String>[];
    for (var k in mainKeys) {
      if (!j.containsKey(k)) {
        j[k] = mainJson[k];
        final pk = '@$k';
        if (mainJson.containsKey(pk)) {
          j[pk] = mainJson[pk];
        }

        added.add(k);
      }
    }
    return added;
  }

  List<String> _removed(Map<String, dynamic> j) {
    final rl = <String>[];
    for (var k in j.keys) {
      if (k[0] != '@') {
        if (!mainJson.containsKey(k)) {
          rl.add(k);
        }
      }
    }
    return rl;
  }
}
