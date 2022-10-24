import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:app_filmes/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';

class ChecagemPage extends StatefulWidget {
  const ChecagemPage({super.key});

  @override
  State<ChecagemPage> createState() => _ChecagemPageState();
}

class _ChecagemPageState extends State<ChecagemPage> {
  StreamSubscription? streamSubscription;

  get user => null;
  @override
  void initState() {
    super.initState();
    streamSubscription =
        FirebaseAuth.instance.authStateChanges().listen((event) {
      // if(user == null){
      //   Navigator.pushReplacement(context,
      //   MaterialPageRoute(
      //   builder: (builder)=> const LoginPage()));
      // }else{
      //   Navigator.pushReplacement(context,
      //   MaterialPageRoute(
      //     builder: (builder)=> const HomePage()));
      // }
    });
  }

  @override
  void dispose() {
    streamSubscription!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      nextScreen: const LoginPage(),
      splash: Lottie.network(
          'https://assets10.lottiefiles.com/packages/lf20_khzniaya.json'),
      backgroundColor: Colors.black,
      duration: 3500,
      splashTransition: SplashTransition.slideTransition,
      animationDuration: const Duration(seconds: 2),
    );
  }
}
