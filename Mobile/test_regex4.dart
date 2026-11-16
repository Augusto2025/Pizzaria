import 'dart:io';

void main() {
  var content = File('lib/data/models/cart_models.freezed.dart').readAsStringSync();

  // Test more specific regex for field declarations - must start with a type name (not keyword)
  var regex = RegExp(r'^(\s{6})([A-Za-z_]\w*(?:<[^>]+>)?\??\s+_\w+;)', multiLine: true);
  var matches = regex.allMatches(content);
  print('Matches found: ${matches.length}');
  for (var m in matches) {
    print('Match: "${m.group(0)}"');
    print('  Group1 (indent): "${m.group(1)}"');
    print('  Group2 (field): "${m.group(2)}"');
  }
}