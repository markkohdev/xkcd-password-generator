
import 'dart:math';
import 'package:english_words/english_words.dart';
import 'package:english_words/src/words/unsafe.dart';
import 'package:english_words/src/syllables.dart';
import 'package:english_words/src/words/adjectives.dart';
import 'package:english_words/src/words/adjectives_monosyllabic_safe.dart';
import 'package:english_words/src/words/nouns.dart';
import 'package:english_words/src/words/nouns_monosyllabic_safe.dart';

/// The default value of the `maxSyllables` parameter of the [generateWordPairs]
/// function.
const int maxSyllablesDefault = 2;

/// The default value of the `safeOnly` parameter of the [generateWordPairs]
/// function.
const bool safeOnlyDefault = true;

/// The default value of the `top` parameter of the [generateWordPairs]
/// function.
const int topDefault = 10000;

final _random = Random();

/// Randomly generates nice-sounding combinations of words (compounds).
///
/// Will only return combinations of words that are [maxSyllables] long.
///
/// By default, this function will generate combinations from all the top
/// words in the database ([adjectives] and [nouns]). You can tighten it by
/// providing [top]. For example, when [top] is `10`, then only the top ten
/// adjectives and nouns will be used for generating the combinations.
///
/// By default, the generator will not output possibly offensive compounds,
/// such as 'ballsack' or anything containing 'Jew'. You can turn this behavior
/// off by setting [safeOnly] to `false`.
///
/// You can inject [Random] using the [random] parameter.
Iterable<PasswordSequence> generatePasswordSequence(
    int sequenceLength,
    {int maxSyllables = maxSyllablesDefault,
    int top = topDefault,
    bool safeOnly = safeOnlyDefault,
    Random? random}) sync* {
  final rand = random ?? _random;

  bool filterWord(String word) {
    if (safeOnly && unsafe.contains(word)) return false;
    return syllables(word) <= maxSyllables - 1;
  }

  List<String> shortAdjectives;
  List<String> shortNouns;
  if (maxSyllables == maxSyllablesDefault &&
      top == topDefault &&
      safeOnly == safeOnlyDefault) {
    // The most common, precomputed case.
    shortAdjectives = adjectivesMonosyllabicSafe;
    shortNouns = nounsMonosyllabicSafe;
  } else {
    shortAdjectives =
        adjectives.where(filterWord).take(top).toList(growable: false);
    shortNouns = nouns.where(filterWord).take(top).toList(growable: false);
  }

  String pickRandom(List<String> list) => list[rand.nextInt(list.length)];

  // We're in a sync* function, so `while (true)` is okay.
  // ignore: literal_only_boolean_expressions
  while (true) {
    String prefix;
    if (rand.nextBool()) {
      prefix = pickRandom(shortAdjectives);
    } else {
      prefix = pickRandom(shortNouns);
    }
    final suffix = pickRandom(shortNouns);

    // Skip combinations that clash same letters.
    if (prefix.codeUnits.last == suffix.codeUnits.first) continue;

    // Skip combinations that create an unsafe combinations.
    if (safeOnly && unsafePairs.contains("$prefix$suffix")) continue;

    final wordPair = PasswordSequence([prefix, suffix]);
    // Skip words that don't make a nicely pronounced 2-syllable word
    // when combined together.
    if (syllables(wordPair.words.join()) > maxSyllables) continue;
    yield wordPair;
  }
}

class PasswordSequence {

  final List<String> words;

  PasswordSequence(this.words) {
    if (words.isEmpty) {
      throw ArgumentError('The list of words must not be empty');
    }
  }
}