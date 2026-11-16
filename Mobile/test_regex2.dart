import 'dart:io';

void main() {
  var content = File('lib/data/models/cart_models.freezed.dart').readAsStringSync();

  // Test Fix 12 regex
  var regex = RegExp(r'(class _\$\w+Impl\s*\{[\s\S]*?)\n(\s{6,})(\w+\??\s+_\w+;)', multiLine: true);
  var matches = regex.allMatches(content);
  print('Fix 12 Matches found: ${matches.length}');
  for (var m in matches) {
    print('Match: "${m.group(0)}"');
    print('  Group1 (prefix): "${m.group(1)}"');
    print('  Group2 (indent): "${m.group(2)}"');
    print('  Group3 (field): "${m.group(3)}"');
  }

  // Test Fix 9 regex for duplicated final
  var regex2 = RegExp(r'(\s+)final\s+final\s+value\s*=\s*(\w+);', multiLine: true);
  var matches2 = regex2.allMatches(content);
  print('\nFix 9 Matches found: ${matches2.length}');
  for (var m in matches2) {
    print('Match: "${m.group(0)}"');
    print('  Group1 (indent): "${m.group(1)}"');
    print('  Group2 (name): "${m.group(2)}"');
  }
}