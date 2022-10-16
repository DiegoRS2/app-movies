import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'cadastro_page.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'E-mail'),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Senha'),
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        login();
                      },
                      child: Text('Entrar')),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: ((context) => CadastroPage())));
                      }, child: Text('Criar Conta'))
                ]),
          ),
        ),
      ),
    );
  }

  login() async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);

      if (userCredential != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (builder) => const HomePage()));
      }
    } on FirebaseAuthException catch (e) {
      print(e.code.toString());
      if (e.code.toString() == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Ops! Email inválido'),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),),
        margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 100,
        right: 20,
        left: 20),
        ));
      } else if (e.code.toString() == "invalid-email") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Ops! Email inválido'),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),),
        margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 100,
        right: 20,
        left: 20),
        ));
      } else if (e.code.toString() == "wrong-password") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Ops! Senha inválida'),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),),
        margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 100,
        right: 20,
        left: 20),
        ));
      }
    }
  }
}
