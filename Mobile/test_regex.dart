import 'dart:io';

void main() {
  var content = File('lib/data/models/address_models.freezed.dart').readAsStringSync();
  // Match: "      final String? label," - 6 spaces + final + space + type(with optional ? or generics) + space + name + comma
  var regex = RegExp(r'^(\s{6})final\s+(\w+(?:\?|<[^>]+>)?)\s+(\w+)(?=\s*,)', multiLine: true);
  var matches = regex.allMatches(content);
  print('Matches found: ${matches.length}');
  for (var m in matches) {
    print('Match: "${m.group(0)}"');
    print('  Group1 (indent): "${m.group(1)}"');
    print('  Group2 (type): "${m.group(2)}"');
    print('  Group3 (name): "${m.group(3)}"');
  }

  // Also test required params (without ?)
  var regex2 = RegExp(r'^(\s{6})final\s+(\w+(?:<[^>]+>)?)\s+(\w+)(?=\s*,)', multiLine: true);
  var matches2 = regex2.allMatches(content);
  print('\n--- Required params ---');
  print('Matches found: ${matches2.length}');
  for (var m in matches2) {
    print('Match: "${m.group(0)}"');
  }
}