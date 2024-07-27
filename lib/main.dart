import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb; // Import kIsWeb
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xkcd_password_generator/logging.dart';
import 'package:xkcd_password_generator/main_screen.dart';
import 'package:xkcd_password_generator/state_managers.dart';
import 'package:window_size/window_size.dart';
import 'package:xkcd_password_generator/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
    setWindowMinSize(const Size(400, 600));
  }
  runApp(const XKCDPasswordGeneratorApp());
}

class XKCDPasswordGeneratorApp extends StatelessWidget {
  const XKCDPasswordGeneratorApp({super.key});

  // App entry point
  @override
  Widget build(BuildContext context) {
    loggerNoStack.i("Launching XKCD Password Generator App");

    return ChangeNotifierProvider(
      create: (context) => PasswordGenState(),
      child: MaterialApp(
        title: 'XKCD Password Generator',
        theme: appTheme,
        home: MainScreen(),
      ),
    );
  }
}
