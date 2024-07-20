import 'package:flutter/material.dart';
import 'package:xkcd_password_generator/main.dart';
import 'package:xkcd_password_generator/state_managers.dart';

class ActionButtonRow extends StatelessWidget {
  const ActionButtonRow({
    super.key,
    required this.appState,
  });

  final PasswordGenState appState;

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 20, alignment: WrapAlignment.center, children: [
      ElevatedButton(
          onPressed: () {
            appState.clearHistory();
          },
          child: Text('♻️')),
      ElevatedButton(
          onPressed: () {
            appState.getLast();
          },
          child: Text('Last')),
      ElevatedButton(
          onPressed: () {
            appState.getNext();
          },
          child: Text('Next')),
    ]);
  }
}
