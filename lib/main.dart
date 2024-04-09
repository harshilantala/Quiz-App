// import 'package:flutter/material.dart';
// import 'package:quizapp/Pages/login_page.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Flutter Demo',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//           useMaterial3: true,
//         ),
//         home: const LoginPage(title: 'Welcome'),
//
//         // const HomePage({super.key, required this.email});
//         );
//   }
// }

import 'package:flutter/material.dart';
import 'package:quizapp/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';


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
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}