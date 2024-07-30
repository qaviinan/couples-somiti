import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class Politician {
  final String name;
  final int age;
  final String party;
  final String location;
  final String photo;
  final String shortBio;

  Politician({
    required this.name,
    required this.age,
    required this.party,
    required this.location,
    required this.photo,
    required this.shortBio,
  });

  factory Politician.fromCsv(List<dynamic> csvRow) {
    return Politician(
      name: csvRow[0] as String,
      age: int.parse(csvRow[1].toString()), // Explicitly convert to int
      party: csvRow[2] as String,
      location: csvRow[3] as String,
      photo: csvRow[4] as String,
      shortBio: csvRow[5] as String,
    );
  }
}

class PoliticianData {
  static final PoliticianData _instance = PoliticianData._internal();

  factory PoliticianData() {
    return _instance;
  }

  PoliticianData._internal();

  List<Politician> _politicians = [];
  bool _isLoaded = false;

  Future<void> loadCsvData() async {
    if (_isLoaded) return;
    final data = await rootBundle.loadString('assets/people.csv');
    final csvTable = CsvToListConverter(eol: "\n").convert(data);

    _politicians = csvTable
        .skip(1) // Skip the header row
        .map((csvRow) => Politician.fromCsv(csvRow))
        .toList();
    _isLoaded = true;
  }

  List<Politician> get politicians => _politicians;
}
