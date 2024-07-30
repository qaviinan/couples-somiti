import 'package:flutter/material.dart';
import 'quiz.dart';
import 'rankings.dart';
import 'user.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0; 

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = QuizPage();
      case 1:
        page = RankingsPage();
      case 2:
        page = UserSettingsPage();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return Scaffold(
      body: Container(
        child: page,
      ),
      bottomNavigationBar: SafeArea(
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Vote',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Rankings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}