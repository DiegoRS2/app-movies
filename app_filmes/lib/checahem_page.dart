import 'dart:async';
import 'package:app_filmes/home_page.dart';
import 'package:app_filmes/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
     streamSubscription = FirebaseAuth.instance.authStateChanges().listen((event) {
    
      if(user == null){
        Navigator.pushReplacement(context, 
        MaterialPageRoute(
        builder: (builder)=> const LoginPage()));
      }else{
        Navigator.pushReplacement(context, 
        MaterialPageRoute(
          builder: (builder)=> const HomePage()));
      }
    });
  }

  @override
  void dispose(){
    streamSubscription!.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}