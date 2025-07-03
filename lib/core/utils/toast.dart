import 'package:ezy_appbuilder/main.dart';
import 'package:flutter/material.dart';

class Toast {
  static void error(
    String message, {
    Duration duration = const Duration(seconds: 1),
  }) {
    final context = navigatorKey.currentState?.overlay?.context;
    if (context == null) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
    );
  }

  static void success(
    String message, {
    Duration duration = const Duration(seconds: 1),
  }) {
    final context = navigatorKey.currentState?.overlay?.context;
    if (context == null) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        backgroundColor: Colors.green,
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
