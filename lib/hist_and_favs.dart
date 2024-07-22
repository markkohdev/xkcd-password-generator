import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xkcd_password_generator/password_sequence.dart';
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
    var appState = context.watch<PasswordGenState>();

    List<PasswordSequence> favorites = appState.favorites;

    return Column(children: [
      ListTitleCard(title: "Favorites"),
      ...favorites.reversed.map((passwordSequece) {
        return PasswordListCard(
          passwordSequence: passwordSequece,
        );
      }),
    ]);
  }
}

class HistoryList extends StatelessWidget {
  const HistoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<PasswordGenState>();

    List<PasswordSequence> history = appState.history;

    return Column(children: [
      ListTitleCard(title: "History"),
      ...history.reversed.map((passwordSequece) {
        return PasswordListCard(
          passwordSequence: passwordSequece,
        );
      }),
    ]);
  }
}

class PasswordListCard extends StatelessWidget {
  const PasswordListCard({
    super.key,
    required this.passwordSequence,
  });

  final PasswordSequence passwordSequence;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
              fit: BoxFit.scaleDown,
              child: SelectableText(passwordSequence.asLowerCase)),
        ));
  }
}

class ListTitleCard extends StatelessWidget {
  const ListTitleCard({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var headerStyle = theme.textTheme.displaySmall!.copyWith(
        color: Theme.of(context).colorScheme.onTertiary,
        fontWeight: FontWeight.bold);

    return FittedBox(
      child: Card(
        color: theme.colorScheme.tertiary,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: headerStyle,
          ),
        ),
      ),
    );
  }
}
