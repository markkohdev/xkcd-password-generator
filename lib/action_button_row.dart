import 'package:flutter/material.dart';
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
          appState.toggleSettings();
        },
        child: Text('⚙️'),
      ),
      ElevatedButton(
        onPressed: () {
          showClearDialog(context);
        },
        child: Text('♻️'),
      ),
      ElevatedButton(
          onPressed: () {
            appState.getNext();
          },
          child: Text('Next')),
      ElevatedButton(
          onPressed: () {
            appState.addToFavorites();
          },
          child: Text('❤️')),
    ]);
  }

  Future<dynamic> showClearDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm'),
          content:
              Text('Do you want to clear the history, favorites, or both?'),
          actions: <Widget>[
            TextButton(
              child: Text('History'),
              onPressed: () {
                // Assuming PasswordGenState is accessible as appState
                appState.clearHistory();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Favorites'),
              onPressed: () {
                // Assuming PasswordGenState is accessible as appState
                appState
                    .clearFavorites(); // Implement this method in PasswordGenState
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Both'),
              onPressed: () {
                // Assuming PasswordGenState is accessible as appState
                appState.clearHistory();
                appState
                    .clearFavorites(); // Implement this method in PasswordGenState
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
