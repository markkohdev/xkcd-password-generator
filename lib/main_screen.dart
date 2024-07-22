import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xkcd_password_generator/action_button_row.dart';
import 'package:xkcd_password_generator/app_footer.dart';
import 'package:xkcd_password_generator/app_header.dart';
import 'package:xkcd_password_generator/candidate_password_card.dart';
import 'package:xkcd_password_generator/hist_and_favs.dart';
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
