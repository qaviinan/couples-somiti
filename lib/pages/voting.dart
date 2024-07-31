import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import 'candidate_data.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class VotingPage extends StatefulWidget {
  @override
  State<VotingPage> createState() => _VotingPageState();
}

class _VotingPageState extends State<VotingPage> {
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
                padding: const EdgeInsets.all(2.0),
                allowedSwipeDirection: AllowedSwipeDirection.only(right: true, left: true),
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
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                ClipRRect(
                  child: Container(
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
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.7, 1] 
                          )
                      ),
                      child: Column(
                        children: [
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                politician.name,
                                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).canvasColor, // Example: using primary color
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                politician.age.toString(),
                                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                  // fontWeight: FontWeight.bold,
                                  color: Theme.of(context).canvasColor,
                                ), // Example: using primary color
                              ),
                            ],
                          ),
                        ]
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        politician.shortBio,
                        style: Theme.of(context).textTheme.bodyLarge,
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
                      SizedBox(height: 40),
                      Text(
                        """Salimullah Khan (Bengali: সলিমুল্লাহ খান, Bengali pronunciation: [solimulːa kʰaːn]; born 18 August 1958) is a Bangladeshi writer, academic, teacher and public intellectual. Khan explores national and international politics and culture using Marxist and Lacanian theories. Informed and influenced by Ahmed Sofa's thoughts, his exploration of Bangladesh's politics and culture has a significant following among the country's young generation of writers and thinkers. Khan translated the works of Plato, James Rennell, Charles Baudelaire, Frantz Fanon, Dorothee Sölle into Bengali.[1][2][3][4][5] In Bangladesh, he is a regular guest in talk shows on national and international political issues.
                        Salimullah Khan (Bengali: সলিমুল্লাহ খান, Bengali pronunciation: [solimulːa kʰaːn]; born 18 August 1958) is a Bangladeshi writer, academic, teacher and public intellectual. Khan explores national and international politics and culture using Marxist and Lacanian theories. Informed and influenced by Ahmed Sofa's thoughts, his exploration of Bangladesh's politics and culture has a significant following among the country's young generation of writers and thinkers. Khan translated the works of Plato, James Rennell, Charles Baudelaire, Frantz Fanon, Dorothee Sölle into Bengali.[1][2][3][4][5] In Bangladesh, he is a regular guest in talk shows on national and international political issues.
                        Salimullah Khan (Bengali: সলিমুল্লাহ খান, Bengali pronunciation: [solimulːa kʰaːn]; born 18 August 1958) is a Bangladeshi writer, academic, teacher and public intellectual. Khan explores national and international politics and culture using Marxist and Lacanian theories. Informed and influenced by Ahmed Sofa's thoughts, his exploration of Bangladesh's politics and culture has a significant following among the country's young generation of writers and thinkers. Khan translated the works of Plato, James Rennell, Charles Baudelaire, Frantz Fanon, Dorothee Sölle into Bengali.[1][2][3][4][5] In Bangladesh, he is a regular guest in talk shows on national and international political issues.""",
                        style: Theme.of(context).textTheme.bodyLarge,
                      )

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

