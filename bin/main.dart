
import 'dart:io';
import '../src/from_arb.dart';
import '../src/to_arb.dart';
import '../src/updater.dart';


void printHelp() {
  print('''
./translate generate - create translation file, example:
./translate generate --locale ru_RU --output-dir messages --dir lib --dir /home/vscode/.pub-cache/git/angular_components-a8ea3b8c56201b42655b11f9c67bdddcc603642b/ngcomponents/lib

./translate merge - merge translation files

./translate update - generate dart files with translation:
./translate update --output-dir lib/messages --dir lib --dir /home/vscode/.pub-cache/git/angular_components-a8ea3b8c56201b42655b11f9c67bdddcc603642b/ngcomponents/lib messages/intl_messages_en.arb
''');
}
void main(List<String> args) async {
  if (args.isEmpty) {
    printHelp();
    exit(1);
  }
  final c = args[0];
  final u = Updater(Directory('messages'));

  if (c == 'generate') {
    to_arb(args.sublist(1));
  } else if (c == 'merge') {
    await u.upd();
  } else if (c == 'update') {
    from_arb(args.sublist(1));
  } else {
    printHelp();
  }
}
