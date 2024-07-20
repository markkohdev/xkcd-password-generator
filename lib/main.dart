import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xkcd_password_generator/main_screen.dart';
import 'package:xkcd_password_generator/state_managers.dart';

void main() {
  runApp(const XKCDPasswordGeneratorApp());
}

class XKCDPasswordGeneratorApp extends StatelessWidget {
  const XKCDPasswordGeneratorApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
