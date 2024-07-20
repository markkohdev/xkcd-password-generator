import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Column(
      children: [
        Text(
          '© 2024 Mark Koh | Made with ❤️ in Golden, CO',
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}
