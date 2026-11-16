import 'dart:io';

void main() {
  var content = File('lib/data/models/cart_models.freezed.dart').readAsStringSync();

  // Test regex that excludes Dart statement keywords
  // Match: Type name; where Type starts with a letter but is NOT a Dart keyword
  var regex = RegExp(r'^(\s{6})(?!final|throw|return|if|else|for|while|switch|case|default|try|catch|finally|var|const|break|continue|do|in|is|as|assert|await|yield|sync|async)([A-Za-z_]\w*(?:<[^>]+>)?\??\s+_\w+;)', multiLine: true);
  var matches = regex.allMatches(content);
  print('Matches found: ${matches.length}');
  for (var m in matches) {
    print('Match: "${m.group(0)}"');
    print('  Group1 (indent): "${m.group(1)}"');
    print('  Group2 (field): "${m.group(2)}"');
  }
}