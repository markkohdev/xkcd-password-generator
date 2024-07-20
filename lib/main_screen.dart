import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xkcd_password_generator/action_button_row.dart';
import 'package:xkcd_password_generator/app_footer.dart';
import 'package:xkcd_password_generator/app_header.dart';
import 'package:xkcd_password_generator/candidate_password_card.dart';
import 'package:xkcd_password_generator/state_managers.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<PasswordGenState>();
    WordPair candidatePassword = appState.current;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppHeader(),
                  SizedBox(height: 20),
                  CandidatePasswordCard(candidatePassword: candidatePassword),
                  SizedBox(height: 20),
                  ActionButtonRow(appState: appState),
                  SizedBox(height: 50),
                  HistAndFavs(),
                  SizedBox(height: 50),
                  AppFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HistAndFavs extends StatelessWidget {
  const HistAndFavs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: HistoryList()), // Using Expanded for flexibility
          Expanded(child: FavoritesList()), // Using Expanded for flexibility
        ]);
  }
}

class FavoritesList extends StatelessWidget {
  const FavoritesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var headerStyle = theme.textTheme.displaySmall!.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
        fontWeight: FontWeight.bold);
    return Card(
      color: theme.cardColor,
      child: Column(children: [
        FittedBox(
          child: Text(
            'Favorites',
            style: headerStyle,
          ),
        ),
      ]),
    );
  }
}

class HistoryList extends StatelessWidget {
  const HistoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var headerStyle = Theme.of(context).textTheme.displaySmall!.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
        fontWeight: FontWeight.bold);

    var appState = context.watch<PasswordGenState>();
    var theme = Theme.of(context);

    List<WordPair> history = appState.history;

    return Card(
      color: theme.cardColor,
      child: Column(children: [
        FittedBox(
          child: Text(
            'History',
            style: headerStyle,
          ),
        ),
        ...history.map((wordPair) => Text(wordPair.asLowerCase)).toList(),
      ]),
    );
  }
}
