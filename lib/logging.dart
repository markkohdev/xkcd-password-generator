import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart'; // Import foundation to check for release mode

// Set log level based on whether the app is in release mode
var logLevel = kReleaseMode ? Level.info : Level.debug;

var logger = Logger(
  printer: PrettyPrinter(
      methodCount: 2, // Number of method calls to be displayed
      errorMethodCount: 8, // Number of method calls if stacktrace is provided
      lineLength: 120, // Width of the output
      colors: true, // Colorful log messages
      printEmojis: false, // Print an emoji for each log message
      // Should each log print contain a timestamp
      dateTimeFormat: DateTimeFormat.dateAndTime,
  ),
  level: logLevel,
);

var loggerNoStack = Logger(
  printer: PrettyPrinter(
      methodCount: 0, // Number of method calls to be displayed
      lineLength: 120, // Width of the output
      colors: true, // Colorful log messages
      printEmojis: false, // Print an emoji for each log message
      // Should each log print contain a timestamp
      dateTimeFormat: DateTimeFormat.dateAndTime,
  ),
  level: logLevel,
);
