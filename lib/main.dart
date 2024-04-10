
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/screens/SubjectSelectionPage.dart';
import 'package:quizapp/screens/login_screen.dart';
import 'package:quizapp/screens/signup.dart';
import 'SubjectSelectionPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBE4IAKQjZBDdSN-3De5xJy2vsdcSgqBJY",
      appId: '1:542815404122:android:9075a18c1dfbf7b7155863',
      messagingSenderId: '542815404122',
      projectId: 'quiz-app-ced7b',
      // other configurations...
    ),
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Specify the initial route
      routes: {
        '/': (context) => LoginScreen(), // Set the initial route to LoginScreen
        '/signup': (context) => SignupScreen(),
      },
    );
  }
}
