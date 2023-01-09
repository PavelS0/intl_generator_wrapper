# intl_generator_wrapper
Wrapper for intl_genarator with ability to generate Intl messages from calls inside angulardart template

Uses forked version of intl_genarator: https://github.com/PavelS0/intl_generator, you can use this fork directly, without this wrapper.

Use the same parameters as intl_genarator. Added one new parameter "--dir", allows you to specify directory instead of the list of files, the parameter can be specified several times, for example: --dir foo --dir bar

Compile:
dart compile exe bin/main.dart -o translate

Run:

./translate generate - create translation file, example:
./translate generate --locale en_US --output-dir messages --dir lib --dir /home/vscode/.pub-cache/git/angular_components-a8ea3b8c56201b42655b11f9c67bdddcc603642b/ngcomponents/lib

./translate merge - merge translation files

./translate update - generate dart files with translation:
./translate update --output-dir lib/messages --dir lib --dir /home/vscode/.pub-cache/git/angular_components-a8ea3b8c56201b42655b11f9c67bdddcc603642b/ngcomponents/lib messages/intl_messages_en.arb


