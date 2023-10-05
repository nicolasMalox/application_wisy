import 'package:flutter/material.dart';

class Util {
  // The current context.
  BuildContext? _context;

  // Shows a loading indicator.
  void showLoading(BuildContext? context) {
    // Check if the current context is alive.
    bool isCurrentContextAlive;
    try {
      isCurrentContextAlive =
          _context != null && _context!.findRenderObject() != null;
    } on Error catch (e) {
      isCurrentContextAlive = false;
    }

    // Check if the received context is valid.
    bool isReceivedContextValid;
    try {
      isReceivedContextValid =
          context != null && context.findRenderObject() != null;
    } on Error catch (e) {
      isReceivedContextValid = false;
    }

    // If the current context is alive or the received context is not valid, do nothing.
    if (isCurrentContextAlive || !isReceivedContextValid) {
      return;
    }

    // Store the received context.
    _context = context;

    // Show a loading dialog.
    showDialog(
      barrierDismissible: false,
      context: context!,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      useRootNavigator: true,
    );
  }

  // Closes the loading indicator.
  void closeLoading() {
    // If the current context is null, do nothing.
    if (_context == null) {
      return;
    }

    // Close the loading dialog.
    Navigator.of(_context!, rootNavigator: true).pop();

    // Set the current context to null.
    _context = null;
  }
}
