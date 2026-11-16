#!/usr/bin/env dart
// Script to fix freezed generated code bugs:
// 1. Fix _privateConstructorUsedError at TOP LEVEL: change 'static const' to 'final'
// 2. Remove 'final' from operator == methods in _$...Impl classes
// 3. Remove 'final' before 'throw _privateConstructorUsedError' in mixin/abstract classes
// 4. Remove 'final' from constructor parameters (shouldn't have final)
// 5. Fix double semicolons

import 'dart:io';

void main() {
  final libDir = Directory('lib/data/models');
  if (!libDir.existsSync()) {
    print('lib/data/models not found');
    exit(1);
  }

  final files = libDir.listSync().where((f) => f.path.endsWith('.freezed.dart'));

  for (final file in files) {
    final path = file.path;
    var content = File(path).readAsStringSync();
    var originalContent = content;

    // Fix 1: Fix _privateConstructorUsedError at TOP LEVEL
    content = content.replaceAllMapped(
      RegExp(r'^(\s{6})static const _privateConstructorUsedError = UnsupportedError', multiLine: true),
      (match) => '${match.group(1)}final _privateConstructorUsedError = UnsupportedError',
    );

    content = content.replaceAllMapped(
      RegExp(r'^(\s{6})static _privateConstructorUsedError = UnsupportedError', multiLine: true),
      (match) => '${match.group(1)}final _privateConstructorUsedError = UnsupportedError',
    );

    // Fix 2: Remove 'final' before 'operator ==' in _$...Impl classes
    content = content.replaceAllMapped(
      RegExp(r'(@override\s*\n\s{6})final\s+\w+\s+operator\s+==\s*\(', multiLine: true),
      (match) => '${match.group(1)}operator ==(',
    );

    content = content.replaceAllMapped(
      RegExp(r'@override\s+final\s+\w+\s+operator\s+==\s*\(', multiLine: true),
      (match) {
        final m = match.group(0);
        return m != null ? m.replaceFirst('final ', '') : '';
      },
    );

    // Fix 3: Remove 'final' before 'throw _privateConstructorUsedError' in mixin/abstract classes
    content = content.replaceAllMapped(
      RegExp(r'(get \w+\s*=>\s*\n\s+)final\s+throw\s+_privateConstructorUsedError;', multiLine: true),
      (match) => '${match.group(1)}throw _privateConstructorUsedError;',
    );

    content = content.replaceAllMapped(
      RegExp(r'get \w+\s*=>\s*final\s+throw\s+_privateConstructorUsedError;', multiLine: true),
      (match) {
        final m = match.group(0);
        return m != null ? m.replaceFirst('final ', '') : '';
      },
    );

    // Fix 4: Remove 'final' from constructor parameters with default values
    content = content.replaceAllMapped(
      RegExp(r'(\{\s*(?:required\s+)?)(final\s+\w+(?:<[^>]+>)?\s+\w+\s*=[^},\n]+)', multiLine: true),
      (match) {
        final g1 = match.group(1);
        final g2 = match.group(2);
        return (g1 != null && g2 != null) ? '${g1}${g2.replaceFirst('final ', '')}' : (match.group(0) ?? '');
      },
    );

    // Fix 5: Remove 'final' from constructor parameters without default values
    content = content.replaceAllMapped(
      RegExp(r'(\{\s*(?:required\s+)?)final\s+(\w+(?:<[^>]+>)?\s+\w+)(?=\s*[,}\]]\s*)', multiLine: true),
      (match) {
        final g1 = match.group(1);
        final g2 = match.group(2);
        return (g1 != null && g2 != null) ? '${g1}${g2}' : (match.group(0) ?? '');
      },
    );

    // Fix 5b: Remove 'final' from _Impl class constructor parameters with default values (multi-line)
    // Pattern: lines like "    final List<Type> name = const []})" inside constructor params
    content = content.replaceAllMapped(
      RegExp(r'^(\s{4,})final\s+(\w+(?:<[^>]+>)?\s+\w+\s*=\s*const\s+\[\]\})', multiLine: true),
      (match) {
        final indent = match.group(1);
        final param = match.group(2);
        if (indent != null && param != null) {
          return '${indent}${param}';
        }
        return match.group(0) ?? '';
      },
    );

    // Fix 5c: Remove 'final' from _Impl class constructor parameters with default values (without }) on same line
    // Pattern: lines like "    final List<Type> name = const [],"
    content = content.replaceAllMapped(
      RegExp(r'^(\s{4,})final\s+(\w+(?:<[^>]+>)?\s+\w+\s*=\s*const\s+\[\],)', multiLine: true),
      (match) {
        final indent = match.group(1);
        final param = match.group(2);
        if (indent != null && param != null) {
          return '${indent}${param}';
        }
        return match.group(0) ?? '';
      },
    );

    // Fix 5d: Remove 'final' from _Impl class constructor parameters without default values
    // Pattern: lines like "    final List<Type> name," or "    final List<Type> name})"
    content = content.replaceAllMapped(
      RegExp(r'^(\s{4,})final\s+(\w+(?:<[^>]+>)?\s+\w+)(?=\s*[,}\)])', multiLine: true),
      (match) {
        final indent = match.group(1);
        final param = match.group(2);
        if (indent != null && param != null) {
          return '${indent}${param}';
        }
        return match.group(0) ?? '';
      },
    );

    // Fix 6: Remove 'final' from abstract factory constructor parameters
    // Matches: {required final String label,  or  required final String label,
    content = content.replaceAllMapped(
      RegExp(r'(\s+)(?:required\s+)?final\s+(\w+(?:<[^>]+>)?\s+\w+)(?=\s*[,}\)])', multiLine: true),
      (match) {
        final indent = match.group(1);
        final param = match.group(2);
        // Only replace if we're inside a const factory constructor context
        // Check if the line contains the pattern
        return (indent != null && param != null) ? '${indent}required ${param}' : (match.group(0) ?? '');
      },
    );

    // Fix 6b: Remove 'final' from abstract class factory constructor parameters
    // Pattern: "      {final String? label," - 6 spaces + optional { + final + space + type(with optional ?) + space + name + comma
    content = content.replaceAllMapped(
      RegExp(r'^(\s{6})\{?final\s+(\w+(?:\?|<[^>]+>)?)\s+(\w+)(?=\s*,)', multiLine: true),
      (match) {
        final indent = match.group(1);
        final type = match.group(2);
        final name = match.group(3);
        if (indent != null && type != null && name != null) {
          return '${indent}${type} ${name}';
        }
        return match.group(0) ?? '';
      },
    );

    // Fix 6c: Remove 'final' from last parameter in abstract class factory (ends with } or })
    content = content.replaceAllMapped(
      RegExp(r'^(\s{6})\{?final\s+(\w+(?:\?|<[^>]+>)?)\s+(\w+)(?=\s*[}\)])', multiLine: true),
      (match) {
        final indent = match.group(1);
        final type = match.group(2);
        final name = match.group(3);
        if (indent != null && type != null && name != null) {
          return '${indent}${type} ${name}';
        }
        return match.group(0) ?? '';
      },
    );

    // Fix 7: Fix double semicolons
    content = content.replaceAll(';;', ';');

    // Fix 8: Fix 'final return' syntax error in getters
    content = content.replaceAllMapped(
      RegExp(r'(\s+)final\s+return\s+(\w+);', multiLine: true),
      (match) {
        final indent = match.group(1);
        final name = match.group(2);
        if (indent != null && name != null) {
          return '${indent}return $name;';
        }
        return match.group(0) ?? '';
      },
    );

    // Fix 9: Fix 'value = ...' undefined variable in getters (only if not already has 'final')
    // Also fix duplicated 'final final value ='
    content = content.replaceAllMapped(
      RegExp(r'(\s+)final\s+final\s+value\s*=\s*(\w+);', multiLine: true),
      (match) {
        final indent = match.group(1);
        final name = match.group(2);
        if (indent != null && name != null) {
          return '${indent}final value = $name;';
        }
        return match.group(0) ?? '';
      },
    );

    // Fix 9b: Fix 'value = ...' when missing 'final' (but not when already has 'final final')
    // Only match at beginning of line (after indentation)
    content = content.replaceAllMapped(
      RegExp(r'^(\s+)(?!final\s+)value\s*=\s*(\w+);', multiLine: true),
      (match) {
        final indent = match.group(1);
        final name = match.group(2);
        if (indent != null && name != null) {
          return '${indent}final value = $name;';
        }
        return match.group(0) ?? '';
      },
    );

    // Fix 10: Fix 'if (value == null) return null;' pattern after adding 'final value ='
    // This should already work if Fix 9 runs first

    // Fix 11: Add 'final' to field declarations in _Impl classes that have @override but missing final
    // Only match inside class bodies (after "class _$...Impl {" and before the next "}" at class level)
    content = content.replaceAllMapped(
      RegExp(r'(class _\$\w+Impl\s*\{[\s\S]*?@override\s*\n\s{6})(\w+\??\s+\w+;)', multiLine: true),
      (match) {
        final prefix = match.group(1);
        final field = match.group(2);
        if (prefix != null && field != null && !field.startsWith('final ')) {
          return '${prefix}final $field';
        }
        return match.group(0) ?? '';
      },
    );

    // Fix 12: Add 'final' to private field declarations in _Impl classes (like _selectedCustomizations)
    // Match field declarations: 6+ spaces, then Type (not Dart keyword), then _name;
    content = content.replaceAllMapped(
      RegExp(r'^(\s{6,})(?!final|throw|return|if|else|for|while|switch|case|default|try|catch|finally|var|const|break|continue|do|in|is|as|assert|await|yield|sync|async)([A-Za-z_]\w*(?:<[^>]+>)?\??\s+_\w+;)', multiLine: true),
      (match) {
        final indent = match.group(1);
        final field = match.group(2);
        if (indent != null && field != null && !field.startsWith('final ')) {
          return '${indent}final $field';
        }
        return match.group(0) ?? '';
      },
    );

    // Fix 13: Remove 'final' from constructor parameters using 'this.fieldName' (they're implicitly final)
    content = content.replaceAllMapped(
      RegExp(r'(\{\s*(?:required\s+)?)final\s+this\.(\w+)(?=\s*[,}\)])', multiLine: true),
      (match) {
        final prefix = match.group(1);
        final field = match.group(2);
        if (prefix != null && field != null) {
          return '${prefix}this.$field';
        }
        return match.group(0) ?? '';
      },
    );

    if (content != originalContent) {
      File(path).writeAsStringSync(content);
      print('Fixed: $path');
    } else {
      print('No changes needed: $path');
    }
  }

  print('Done!');
}