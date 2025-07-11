import 'dart:math';

/// Utility class for generating unique widget IDs.
class IdGenerator {
  static final Random _random = Random();
  static const String _chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

  /// Generates a unique widget ID with the specified prefix and length.
  static String generateId({String prefix = 'widget', int length = 8}) {
    final buffer = StringBuffer(prefix);
    buffer.write('_');

    for (int i = 0; i < length; i++) {
      buffer.write(_chars[_random.nextInt(_chars.length)]);
    }

    return buffer.toString();
  }
}
