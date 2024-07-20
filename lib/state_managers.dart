import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class PasswordGenState extends ChangeNotifier {
  var current = WordPair.random();
  var history = <WordPair>[];
  var favorites = <WordPair>[];

  /// Get the next word pair and add the current word pair to the history
  void getNext() {
    print("Adding $current to history: $history");
    history.add(current);
    current = WordPair.random();

    notifyListeners();
  }

  
  void getLast() {
    print('In getLast');
    if (history.isNotEmpty) {
      print("In getLast if");
      print("$history");
      current = history.removeLast();
      notifyListeners();
    }
  }

  /// Clear the history and generate a new random word
  void clearHistory() {
    history.clear();
    current = WordPair.random();
    notifyListeners();
  }

  void addToFavorites() {
    favorites.add(current);
    notifyListeners();
  }

  void removeFromFavorites(WordPair wordPair) {
    favorites.remove(wordPair);
    notifyListeners();
  }
}
