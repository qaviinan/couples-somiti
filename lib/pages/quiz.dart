import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
// import 'feed.dart';

class QuizPage extends StatefulWidget {
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: GeneratorPage(),
      ),

    );

  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var favoriteList = appState.favorites;

    return Scaffold(
      appBar: AppBar(
        title: Text('Checked Words'),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Center(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('You have ${favoriteList.length} favorites'),
              ),
              for (var vocab in favoriteList)
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text(vocab.asLowerCase),
              ),  
            ],
          ),
        ),
      ),
    );
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesPage()),
              );
            },
            child: Text('View checked words'),)
        ],
      ),
    );
  }
}

// ...


class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(pair.asLowerCase, style: style),
      ),
    );
  }
}