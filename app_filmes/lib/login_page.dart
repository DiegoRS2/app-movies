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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/login.png'), fit: BoxFit.cover), 
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 130),
              child: const Text("Bem vindo!", style: TextStyle(
                color: Colors.white,
                fontSize: 33
              ),),
            ),
            
          SingleChildScrollView(
             child: Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.5, right: 35,left: 35),
              child: Column(children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Senha',
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))
                  ),
                ),
                const SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Entrar', style: TextStyle(
                      fontSize: 27, fontWeight: FontWeight.w700, color: Color(0xff4c505b),
                    ),),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: const Color(0xff4c505b),
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () {
                          login();
                        },
                        icon: const Icon(Icons.arrow_forward),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    TextButton(onPressed: (){
                       Navigator.push(context, MaterialPageRoute(builder: ((context) => const CadastroPage())));
                    }, child: const Text("Cadastrar-se", style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                      color: Color(0xff4c505b)
                    ),))
                  ],
                )

              ]),
            )
        )],
        ),
      ),
    );
  }

  login() async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
              email: _emailController.text.trim(), password: _passwordController.text.trim());

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
