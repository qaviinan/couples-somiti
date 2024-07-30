import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'src/app.dart';
// import 'src/settings/settings_controller.dart';
// import 'src/settings/settings_service.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/quiz.dart';
import 'pages/home.dart';
import 'pages/rankings.dart';
import 'app_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mukut',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: const Color.fromARGB(255, 140, 241, 190),
          scaffoldBackgroundColor: const Color(
            0xfff6f6f6,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(
              0xfff6f6f6,
            ),
          ),
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
      initialRoute: "/",
      routes: {
        "/": (context) => HomePage(),
        // "/feed": (context) => RankingsPage(),
        // "/quiz": (context) => QuizPage(),
        // "/welcome": (context) => WelcomePage(),
        // "/login": (context) => LoginPage(),
        // "/signup": (context) => SignUpPage(),
      },
      ),
    );
  }
}
