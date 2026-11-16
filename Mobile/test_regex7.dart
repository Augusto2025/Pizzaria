import 'dart:io';

void main() {
  var content = File('lib/data/models/cart_models.freezed.dart').readAsStringSync();

  // Test Fix 11 regex
  var regex = RegExp(r'(class _\$\w+Impl\s*\{[\s\S]*?@override\s*\n\s{6})(\w+\??\s+\w+;)', multiLine: true);
  var matches = regex.allMatches(content);
  print('Fix 11 Matches found: ${matches.length}');
  for (var m in matches) {
    print('Match: "${m.group(0)}"');
    print('  Group1 (prefix): "${m.group(1)}"');
    print('  Group2 (field): "${m.group(2)}"');
  }
}