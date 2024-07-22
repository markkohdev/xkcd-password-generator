import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:xkcd_password_generator/logging.dart';

class PasswordGenState extends ChangeNotifier {
  var current = WordPair.random();
  var history = <WordPair>[];
  var favorites = <WordPair>[];

  /// Get the next word pair and add the current word pair to the history
  void getNext() {
    loggerNoStack.d("Adding $current to history: $history");
    history.add(current);
    current = WordPair.random();

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

  void removeFromFavorites(WordPair wordPair) {
    favorites.remove(wordPair);
    notifyListeners();
  }
}
