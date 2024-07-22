import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xkcd_password_generator/logging.dart';
import 'package:xkcd_password_generator/main_screen.dart';
import 'package:xkcd_password_generator/state_managers.dart';

void main() {
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
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        home: MainScreen(),
      ),
    );
  }
}
