
import 'dart:io';

Future<void> _addToList(List<String> l, Directory dir) async {
  await for (var e in dir.list(recursive: true)) {
    if (e.path.contains('.dart') || e.path.contains('.html')) {
      l.add(e.path);
    }
  }
}

Future<List<String>> getFiles(List<String> libs) async {
  final paths = <String>[];
  for (final l in libs) {
    await _addToList(paths, Directory(l));
  }

  print(paths);
 
  return paths;
}

