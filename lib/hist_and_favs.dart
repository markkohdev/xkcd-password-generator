import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xkcd_password_generator/state_managers.dart';

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
    var appState = context.watch<PasswordGenState>();

    var headerStyle = theme.textTheme.displaySmall!.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
        fontWeight: FontWeight.bold);

    List<WordPair> favorites = appState.favorites;

    return Card(
      color: theme.cardColor,
      child: Column(children: [
        FittedBox(
          child: Text(
            'Favorites',
            style: headerStyle,
          ),
        ),
        ...favorites.reversed.map((wordPair) => Text(wordPair.asLowerCase)),
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
        ...history.reversed.map((wordPair) => Text(wordPair.asLowerCase)),
      ]),
    );
  }
}
