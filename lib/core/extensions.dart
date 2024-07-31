import 'dart:developer' as devtools show log;

extension StringExtention on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}

extension LogExtension on Object {
  void log() => devtools.log(toString());
}
