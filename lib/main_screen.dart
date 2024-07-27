import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xkcd_password_generator/action_button_row.dart';
import 'package:xkcd_password_generator/app_footer.dart';
import 'package:xkcd_password_generator/app_header.dart';
import 'package:xkcd_password_generator/candidate_password_card.dart';
import 'package:xkcd_password_generator/hist_and_favs.dart';
import 'package:xkcd_password_generator/password_sequence.dart';
import 'package:xkcd_password_generator/state_managers.dart';
import 'package:xkcd_password_generator/theme.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<PasswordGenState>();
    PasswordSequence candidatePassword = appState.current;

    return Scaffold(
      backgroundColor: xkcdBlue,
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
                  SettingsArea(),
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

class SettingsArea extends StatelessWidget {
  const SettingsArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<PasswordGenState>();

    if (appState.showSettings) {
      return Column(
        children: [
          SizedBox(height: 20),
          Checkbox(value: false, onChanged: (state) { print(state);}),
          Placeholder(),
        ],
      );
    } else {
      return SizedBox(
        width: 0,
        height: 0,
      );
    }
  }
}
