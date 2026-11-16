import 'dart:io';

void main() {
  var content = File('lib/data/models/cart_models.freezed.dart').readAsStringSync();

  // Test Fix 9 regex for duplicated final
  var regex = RegExp(r'(\s+)final\s+final\s+value\s*=\s*(\w+);', multiLine: true);
  var matches = regex.allMatches(content);
  print('Fix 9 Matches found: ${matches.length}');
  for (var m in matches) {
    print('Match: "${m.group(0)}"');
    print('  Group1 (indent): "${m.group(1)}"');
    print('  Group2 (name): "${m.group(2)}"');
  }
}