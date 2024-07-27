import 'package:flutter/material.dart';
import 'package:xkcd_password_generator/logging.dart';
import 'package:xkcd_password_generator/password_sequence.dart';

class PasswordGenState extends ChangeNotifier {
  var history = <PasswordSequence>[];
  var favorites = <PasswordSequence>[];
  var sequenceLength = 4;
  late var current = PasswordSequence.random(sequenceLength);
  var showSettings = false;

  /// Get the next word pair and add the current word pair to the history
  void getNext() {
    loggerNoStack.d("Adding $current to history: $history");
    history.add(current);
    current = PasswordSequence.random(sequenceLength);

    notifyListeners();
  }

  void toggleSettings() {
    showSettings = !showSettings;
    notifyListeners();
  }

  /// Clear the history and generate a new random word
  void clearHistory() {
    loggerNoStack.d("Clearing history");
    history.clear();
    notifyListeners();
  }

  void addToFavorites() {
    loggerNoStack.d("Adding $current to favorites: $favorites");
    // Only add if the word doesn't already exist in the set
    if (favorites.contains(current)) {
      return;
    }
    favorites.add(current);
    notifyListeners();
  }

  /// Clear the history and generate a new random word
  void clearFavorites() {
    loggerNoStack.d("Clearing favorites");
    favorites.clear();
    notifyListeners();
  }

  void removeFromFavorites(PasswordSequence wordPair) {
    favorites.remove(wordPair);
    notifyListeners();
  }
}
