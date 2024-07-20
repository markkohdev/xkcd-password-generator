import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appTitleStyle = theme.textTheme.displayLarge!.copyWith(
        color: theme.colorScheme.primary, fontWeight: FontWeight.bold);
    // Ensure the subtitle has a minimum font size
    var appSubtitleStyle = theme.textTheme.displaySmall!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.bold,
        fontSize: 12); // Minimum font size

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Calculate 80% of the width
        final subtitleMaxWidth = constraints.maxWidth * 0.8;

        return Column(children: [
          // Title box
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              'XKCD Password Generator',
              style: appTitleStyle,
            ),
          ),
          // Subtitle box with constrained width and wrapping enabled
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: subtitleMaxWidth, // Use the calculated max width
            ),
            child: Text(
              'Passwords that are easy to remember, but hard to guess!',
              textAlign: TextAlign.center,
              style: appSubtitleStyle,
              softWrap: true, // Enable text wrapping
              maxLines: 2, // Optional: limit the number of lines
            ),
          ),
          SizedBox(height: 10),

          AboutDropdown(),
        ]);
      },
    );
  }
}

class AboutDropdown extends StatelessWidget {
  const AboutDropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    var aboutStyle =
        theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.primary);

    return Theme(
      data: theme,
      child: Container(
        decoration: BoxDecoration(
          // border: Border.all(
          //   color: theme.colorScheme.primary,
          //   width: 1,
          // ),
          borderRadius: BorderRadius.circular(30),
          color: theme.colorScheme.secondary.withOpacity(0.2),
        ),
        child: ExpansionTile(
          title: Text('About', style: TextStyle(fontWeight: FontWeight.bold)),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "This password generator is inspired by the XKCD comic strip #936.\n\n"
                    "The core idea of it is that a password made up of four random words is easier to remember "
                    "and harder to guess than a shorter password with a mix of letters, numbers, and symbols. "
                    "Find out more about XKCD #936 here.",
                    style: aboutStyle,
                  ),
                  SizedBox(height: 10),
                  ComicViewer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "All rights for the above comic reserved to Randall Munroe.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 9,
                          color: theme.colorScheme.onPrimaryFixedVariant),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ComicViewer extends StatelessWidget {
  const ComicViewer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.0),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: InkWell(
          onTap: () async {
            final url = Uri.parse('https://xkcd.com/936/');
            if (await canLaunchUrl(url)) {
              await launchUrl(url);
            } else {
              throw 'Could not launch $url';
            }
          },
          child: InteractiveViewer(
            panEnabled: true,
            minScale: 1.0,
            maxScale: 4,
            child: Image.asset('assets/images/comic.png'),
          ),
        ),
      ),
    );
  }
}
