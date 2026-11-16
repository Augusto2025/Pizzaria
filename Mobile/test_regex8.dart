import 'dart:io';

void main() {
  var content = File('lib/data/models/cart_models.freezed.dart').readAsStringSync();

  // Test Fix 12 regex
  var regex = RegExp(r'^(\s{6,})(?!final|throw|return|if|else|for|while|switch|case|default|try|catch|finally|var|const|break|continue|do|in|is|as|assert|await|yield|sync|async)([A-Za-z_]\w*(?:<[^>]+>)?\??\s+_\w+;)', multiLine: true);
  var matches = regex.allMatches(content);
  print('Fix 12 Matches found: ${matches.length}');
  for (var m in matches) {
    print('Match: "${m.group(0)}"');
    print('  Group1 (indent): "${m.group(1)}"');
    print('  Group2 (field): "${m.group(2)}"');
    print('  Starts with final: ${m.group(2)!.startsWith('final ')}');
  }
}