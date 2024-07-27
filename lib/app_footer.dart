import 'package:flutter/material.dart';
import 'package:xkcd_password_generator/theme.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var footerTextTheme = theme.textTheme.bodySmall!.copyWith(
        fontWeight: FontWeight.bold, fontFamily: xkcdFont,
        color: theme.colorScheme.surface);

    return Column(
      children: [
        SelectableText.rich(
  TextSpan(
    children: [
      WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: Icon(Icons.copyright, size: footerTextTheme.fontSize, color: footerTextTheme.color),
      ),
      TextSpan(text: ' 2024 Mark Koh | Made with '),
      WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: Icon(Icons.favorite, size: footerTextTheme.fontSize, color: footerTextTheme.color),
      ),
      TextSpan(text: ' in Golden, CO'),
    ],
    style: footerTextTheme,
  ),
)
      ],
    );
  }
}
