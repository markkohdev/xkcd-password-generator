import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';
import 'package:xkcd_password_generator/state_managers.dart';

class CandidatePasswordCard extends StatelessWidget {
  CandidatePasswordCard({
    super.key,
    required this.candidatePassword,
  });

  final WordPair candidatePassword;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var appState = context.watch<PasswordGenState>();
    final textStyle = theme.textTheme.displayMedium!.copyWith(
        color: theme.colorScheme.onPrimary, fontWeight: FontWeight.bold);


    return Card(
      color: theme.colorScheme.tertiary,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Ensure the Row takes minimum space
          children: [
            Flexible( // Make the text widget flexible
              child: FittedBox(
                fit: BoxFit.scaleDown, // Ensure the text scales down to fit
                child: Text(
                  candidatePassword.asLowerCase,
                  style: textStyle,
                  semanticsLabel: "${candidatePassword.first} ${candidatePassword.second}",
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.copy, color: theme.colorScheme.onPrimary),
              onPressed: () {
                appState.addToFavorites();
                Clipboard.setData(ClipboardData(text: candidatePassword.asLowerCase));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Copied to clipboard')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
