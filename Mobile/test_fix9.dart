import 'dart:io';

void main() {
  var content = File('lib/data/models/cart_models.freezed.dart').readAsStringSync();
  var originalContent = content;

  // Fix 9: Fix duplicated 'final final value ='
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

  if (content != originalContent) {
    print('Content changed!');
    print('Original has duplicated: ${originalContent.contains('final final value =')}');
    print('New has duplicated: ${content.contains('final final value =')}');
  } else {
    print('No changes');
  }
}