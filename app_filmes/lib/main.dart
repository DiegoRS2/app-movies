import 'package:app_filmes/checahem_page.dart';
import 'package:app_filmes/firebase_options.dart';
import 'package:app_filmes/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app_filmes/firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Filmes e séries',
      theme: ThemeData(
  
        primarySwatch: Colors.pink,
      ),
      home: ChecagemPage(),
    );
  }
}

