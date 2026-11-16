import 'dart:io';

void main() {
  var content = File('lib/data/models/cart_models.freezed.dart').readAsStringSync();
  var originalContent = content;

  print('=== Original content has "final final value =": ${content.contains('final final value =')}');

  // Fix 9: Fix duplicated 'final final value ='
  print('\n--- Running Fix 9 ---');
  content = content.replaceAllMapped(
    RegExp(r'(\s+)final\s+final\s+value\s*=\s*(\w+);', multiLine: true),
    (match) {
      final indent = match.group(1);
      final name = match.group(2);
      if (indent != null && name != null) {
        print('Fix 9 matched: "${match.group(0)}"');
        print('  Replacing with: "${indent}final value = $name;"');
        return '${indent}final value = $name;';
      }
      return match.group(0) ?? '';
    },
  );
  print('After Fix 9 - has "final final value =": ${content.contains('final final value =')}');
  print('After Fix 9 - has "final value =": ${content.contains('final value = _selectedCustomizations;')}');

  // Fix 9b: Fix 'value = ...' when missing 'final'
  print('\n--- Running Fix 9b ---');
  content = content.replaceAllMapped(
    RegExp(r'(\s+)(?!final\s+)value\s*=\s*(\w+);', multiLine: true),
    (match) {
      final indent = match.group(1);
      final name = match.group(2);
      if (indent != null && name != null) {
        print('Fix 9b matched: "${match.group(0)}"');
        print('  Replacing with: "${indent}final value = $name;"');
        return '${indent}final value = $name;';
      }
      return match.group(0) ?? '';
    },
  );
  print('After Fix 9b - has "final final value =": ${content.contains('final final value =')}');
  print('After Fix 9b - has "final value =": ${content.contains('final value = _selectedCustomizations;')}');

  // Fix 11: Add 'final' to field declarations in _Impl classes
  print('\n--- Running Fix 11 ---');
  var fix11Regex = RegExp(r'(class _\$\w+Impl\s*\{[\s\S]*?@override\s*\n\s{6})(\w+\??\s+\w+;)', multiLine: true);
  var fix11Matches = fix11Regex.allMatches(content);
  print('Fix 11 matches: ${fix11Matches.length}');
  for (var m in fix11Matches) {
    print('  Match: "${m.group(0)}"');
    print('    Group2: "${m.group(2)}"');
  }
  content = content.replaceAllMapped(
    fix11Regex,
    (match) {
      final prefix = match.group(1);
      final field = match.group(2);
      if (prefix != null && field != null && !field.startsWith('final ')) {
        print('Fix 11 matched field: "$field"');
        return '${prefix}final $field';
      }
      return match.group(0) ?? '';
    },
  );
  print('After Fix 11 - has "final final value =": ${content.contains('final final value =')}');
  print('After Fix 11 - has "final value =": ${content.contains('final value = _selectedCustomizations;')}');

  // Fix 12: Add 'final' to private field declarations
  print('\n--- Running Fix 12 ---');
  var fix12Regex = RegExp(r'^(\s{6,})(?!final|throw|return|if|else|for|while|switch|case|default|try|catch|finally|var|const|break|continue|do|in|is|as|assert|await|yield|sync|async)([A-Za-z_]\w*(?:<[^>]+>)?\??\s+_\w+;)', multiLine: true);
  var fix12Matches = fix12Regex.allMatches(content);
  print('Fix 12 matches: ${fix12Matches.length}');
  for (var m in fix12Matches) {
    print('  Match: "${m.group(0)}"');
    print('    Group2: "${m.group(2)}"');
  }
  content = content.replaceAllMapped(
    fix12Regex,
    (match) {
      final indent = match.group(1);
      final field = match.group(2);
      if (indent != null && field != null && !field.startsWith('final ')) {
        print('Fix 12 matched field: "$field"');
        return '${indent}final $field';
      }
      return match.group(0) ?? '';
    },
  );
  print('After Fix 12 - has "final final value =": ${content.contains('final final value =')}');
  print('After Fix 12 - has "final value =": ${content.contains('final value = _selectedCustomizations;')}');

  // Fix 13: Remove 'final' from constructor parameters using 'this.fieldName'
  print('\n--- Running Fix 13 ---');
  var fix13Regex = RegExp(r'(\{\s*(?:required\s+)?)final\s+this\.(\w+)(?=\s*[,}\)])', multiLine: true);
  var fix13Matches = fix13Regex.allMatches(content);
  print('Fix 13 matches: ${fix13Matches.length}');
  for (var m in fix13Matches) {
    print('  Match: "${m.group(0)}"');
  }
  content = content.replaceAllMapped(
    fix13Regex,
    (match) {
      final prefix = match.group(1);
      final field = match.group(2);
      if (prefix != null && field != null) {
        print('Fix 13 matched: "${match.group(0)}"');
        return '${prefix}this.$field';
      }
      return match.group(0) ?? '';
    },
  );

  print('\n=== Final result ===');
  print('Content changed: ${content != originalContent}');
  print('Has "final final value =": ${content.contains('final final value =')}');
  print('Has "final value =": ${content.contains('final value = _selectedCustomizations;')}');

  if (content != originalContent) {
    File('lib/data/models/cart_models.freezed.dart').writeAsStringSync(content);
    print('File written!');
  }
}