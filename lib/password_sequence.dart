
import 'dart:math';
// import 'package:english_words/english_words.dart';
import 'package:english_words/src/words/unsafe.dart';
import 'package:english_words/src/syllables.dart';
import 'package:english_words/src/words/adjectives.dart';
import 'package:english_words/src/words/adjectives_monosyllabic_safe.dart';
import 'package:english_words/src/words/nouns.dart';
import 'package:english_words/src/words/nouns_monosyllabic_safe.dart';

/// The default value of the `maxSyllables` parameter of the [generatePasswordSequences]
/// function.
const int maxSyllablesDefault = 8;

/// The default value of the `safeOnly` parameter of the [generatePasswordSequences]
/// function.
const bool safeOnlyDefault = true;

/// The default value of the `top` parameter of the [generatePasswordSequences]
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
    var sequence = <String>[];
    for (var i = 0; i < sequenceLength - 1; i++) {
      if (rand.nextBool()) {
        prefix = pickRandom(shortAdjectives);
      } else {
        prefix = pickRandom(shortNouns);
      }
      sequence.add(prefix);
    }
    // if (rand.nextBool()) {
    //   prefix = pickRandom(shortAdjectives);
    // } else {
    //   prefix = pickRandom(shortNouns);
    // }
    // Always end in a noun for memorability
    final suffix = pickRandom(shortNouns);
    sequence.add(suffix);

    for (var i = 0; i < sequence.length - 1; i++) {
      // Skip combinations that clash same letters.
      if (sequence[i].codeUnits.last == sequence[i + 1].codeUnits.first) continue;

      // Skip combinations that create an unsafe combinations.
      if (safeOnly && unsafePairs.contains("${sequence[i]}${sequence[i + 1]}")) continue;
    }

    final passwordSequence = PasswordSequence(sequence);
    // Skip words that don't make a nicely pronounced 2-syllable word
    // when combined together.
    if (syllables(passwordSequence.words.join()) > maxSyllables) continue;
    yield passwordSequence;
  }
}

class PasswordSequence {

  final List<String> words;

  PasswordSequence(this.words) {
    if (words.isEmpty) {
      throw ArgumentError('The list of words must not be empty');
    }
  }

  /// Creates a single [PasswordSeqnece] randomly. Takes the same parameters as
  /// [generatePasswordSequence].
  ///
  /// If you need more than one word pair, this constructor will be inefficient.
  /// Get an iterable of random word pairs instead by calling
  /// [generatePasswordSequence].
  factory PasswordSequence.random(
      int sequenceLength,
      {int maxSyllables = maxSyllablesDefault,
      int top = topDefault,
      bool safeOnly = safeOnlyDefault,
      Random? random}) {
    random ??= _random;
    final sequenceIterable = generatePasswordSequence(
        sequenceLength,
        maxSyllables: maxSyllables,
        top: top,
        safeOnly: safeOnly,
        random: random);
    return sequenceIterable.first;
  }

    /// Returns the word pair as a simple string, with second word capitalized,
  /// like `"keyFrame"` or `"franceLand"`. This is informally called
  /// "camel case".
  late final String asCamelCase = _createCamelCase();

  /// Returns the word pair as a simple string, in lower case,
  /// like `"keyframe"` or `"franceland"`.
  late final String asLowerCase = asString.toLowerCase();

  /// Returns the word pair as a simple string, with each word capitalized,
  /// like `"KeyFrame"` or `"BigUsa"`. This is informally called "pascal case".
  late final String asPascalCase = _createPascalCase();

  /// Returns the word pair as a simple string, separated by an underscore,
  /// like `"key_frame"` or `"big_usa"`. This is informally called "snake case".
  late final String asSnakeCase = _createSnakeCase();

  /// Returns the word pair as a simple string, like `"keyframe"`
  /// or `"bigFrance"`.
  late final String asString = words.join();

  late final String asSemanticLabel = _createSemanticLabel();

  /// Returns the word pair as a simple string, in upper case,
  /// like `"KEYFRAME"` or `"FRANCELAND"`.
  late final String asUpperCase = asString.toUpperCase();

  @override
  int get hashCode =>
      (words.map((word) => word.hashCode.toString()).join()).hashCode;

  @override
  bool operator ==(Object other) {
    if (other is PasswordSequence) {
      return words.length == other.words.length &&
          List.generate(words.length, (i) => words[i] == other.words[i])
              .reduce((a, b) => a && b);
    } else {
      return false;
    }
  }

  /// Returns a string representation of the [PassowrdSequence] where the two parts
  /// are joined by [separator].
  ///
  /// For example, `new PassowrdSequence('mine', 'craft').join()` returns `minecraft`.
  String join([String separator = '']) => words.join(separator);

  /// Creates a new [PasswordSeqence] with all words in lower case.
  PasswordSequence toLowerCase() => PasswordSequence(words.map((word) => word.toLowerCase()).toList());

  @override
  String toString() => asString;

  String _capitalize(String word) {
    return "${word[0].toUpperCase()}${word.substring(1).toLowerCase()}";
  }

  String _createCamelCase() => words.first.toLowerCase() + words.sublist(1).map(_capitalize).join();

  String _createPascalCase() =>  words.map(_capitalize).join();

  String _createSnakeCase() => words.map((w) => w.toLowerCase()).join('_');
  
  String _createSemanticLabel() => words.map((w) => w.toLowerCase()).join(' ');

  
}