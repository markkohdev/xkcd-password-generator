import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:xkcd_password_generator/password_sequence.dart';
import 'package:xkcd_password_generator/state_managers.dart';
import 'package:xkcd_password_generator/theme.dart';

class CandidatePasswordCard extends StatelessWidget {
  CandidatePasswordCard({
    super.key,
    required this.candidatePassword,
  });

  final PasswordSequence candidatePassword;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var appState = context.watch<PasswordGenState>();
    final textStyle =
        theme.textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold);
    final breakdownStyle =
        theme.textTheme.displaySmall!.copyWith(fontFamily: xkcdFont);

    return Card(
      // color: theme.colorScheme.primary,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Ensure the Row takes minimum space
          children: [
            Flexible(
              // Make the text widgxet flexible
              child: FittedBox(
                fit: BoxFit.scaleDown, // Ensure the text scales down to fit
                child: Column(children: [
                  SelectableText(
                    candidatePassword.asLowerCase,
                    style: textStyle,
                    semanticsLabel: candidatePassword.asSemanticLabel,
                  ),
                  SizedBox(height: 15),
                  SelectableText(
                    '"${candidatePassword.asSemanticLabel}"',
                    style: breakdownStyle,
                  ),
                ]),
              ),
            ),
            IconButton(
              icon: Icon(Icons.copy, 
              // color: theme.colorScheme.onPrimary
              ),
              onPressed: () {
                appState.addToFavorites();
                Clipboard.setData(
                    ClipboardData(text: candidatePassword.asLowerCase));
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
