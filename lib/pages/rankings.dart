import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import 'candidate_data.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class RankingsPage extends StatefulWidget {
  @override
  State<RankingsPage> createState() => _RankingsPageState();
}

class _RankingsPageState extends State<RankingsPage> {
  final _random = Random();
  List<Politician> _politicians = [];

  @override
  void initState() {
    super.initState();
    _loadPoliticians();
  }

  Future<void> _loadPoliticians() async {
    await PoliticianData().loadCsvData();
    setState(() {
      _politicians = PoliticianData().politicians;
    });
  }

  // Politician _getRandomPolitician() {
  //   final politicians = PoliticianData().politicians;
  //   return politicians[_random.nextInt(politicians.length)];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: _politicians.isEmpty
            ? Center(child: CircularProgressIndicator())
            : CardSwiper(
                cardsCount: _politicians.length,
                cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                  return Container(
                    width: double.infinity,
                    child: PoliticianCard(
                      politician: _politicians[index],
                      onLike: () {
                        // Handle like action
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class PoliticianCard extends StatelessWidget {
  final Politician politician;
  final VoidCallback onLike;

  const PoliticianCard({
    required this.politician,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.white,
            elevation: 5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 300, // Fixed height for the image
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                    image: DecorationImage(
                      image: NetworkImage(politician.photo),
                      fit: BoxFit.cover,
                      onError: (error, stackTrace) {
                        print('Failed to load image: $error');
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        politician.name,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Wrap(
                        spacing: 8.0,
                        children: [
                          Chip(
                            label: Text(politician.location),
                            backgroundColor: Colors.blueAccent,
                          ),
                          Chip(
                            label: Text(politician.party),
                            backgroundColor: Colors.greenAccent,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: onLike,
                        icon: Icon(Icons.thumb_up),
                        label: Text('Like'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

