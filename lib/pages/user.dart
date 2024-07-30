import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

// class UserSettingsPage extends StatefulWidget {
//   const UserSettingsPage({super.key});

//   @override
//   State<UserSettingsPage> createState() => _UserSettingsPageState();
// }

// class _UserSettingsPageState extends State<UserSettingsPage> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

class UserSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Politicians Page'),
      ),
body: FutureBuilder<List<Politician>>(
        future: loadCsvData(),
        builder: (context, snapshot) {
          print('Snapshot state: ${snapshot.connectionState}');  // Debug statement

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print('Error: ${snapshot.error}');  // Debug statement
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final politicians = snapshot.data ?? [];
          print('Number of politicians: ${politicians.length}');  // Debug statement

          if (politicians.isEmpty) {
            return Center(child: Text('No data found'));  // Handle empty state
          }

          return ListView.builder(
            itemCount: politicians.length,
            itemBuilder: (context, index) {
              final politician = politicians[index];
              return PoliticianItem(
                name: politician.name,
                age: politician.age,
                party: politician.party,
                location: politician.location,
                photo: politician.photo,
                shortBio: politician.shortBio,
              );
            },
          );
        },
      )
    );
  }
}

class PoliticianItem extends StatelessWidget {
  final String name;
  final int age;
  final String party;
  final String location;
  final String photo;
  final String shortBio;

  const PoliticianItem({
    required this.name,
    required this.age,
    required this.party,
    required this.location,
    required this.photo,
    required this.shortBio,
  });

  @override
  Widget build(BuildContext context) {
    print('Building item for $name');  // Debug statement
    return Card(
      child: ListTile(
        leading: Image.network(photo, errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.error);  // Handle image loading error
        }),
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Age: $age'),
            Text('Party: $party'),
            Text('Location: $location'),
            Text('Bio: $shortBio'),
          ],
        ),
      ),
    );
  }
}

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


Future<List<Politician>> loadCsvData() async {
  final data = await rootBundle.loadString('assets/people.csv');
  print('CSV Data: $data'); // Debug statement

  // Convert the CSV data into a list of rows
  final csvTable = CsvToListConverter(eol: "\n").convert(data);
  
  // Print each row for debugging
  for (var row in csvTable) {
    print('Row: $row');
  }

  // Skip the header row and parse each remaining row
  final politicians = csvTable
      // .skip(1) // Skip the header row
      .map((csvRow) => Politician.fromCsv(csvRow))
      .toList();

  print('Parsed Politicians: $politicians'); // Debug statement
  return politicians;
}
