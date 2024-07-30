import 'dart:math';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'pages/candidate_data.dart';

class MyAppState extends ChangeNotifier {
  List<Politician> _politicians = [];
  late Politician _currentPolitician;
  var current = WordPair.random(); // wordpair

  MyAppState() {
    _loadPoliticians();
  }

  Future<void> _loadPoliticians() async {
    await PoliticianData().loadCsvData();
    _politicians = PoliticianData().politicians;
    _currentPolitician = _politicians.first;
    notifyListeners();
  }

  List<Politician> get politicians => _politicians;

  Politician get currentPolitician => _currentPolitician;

  void getNextPolitician() {
    _currentPolitician = _politicians[Random().nextInt(_politicians.length)];
    notifyListeners();
  }
  
  // wordpair
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

}