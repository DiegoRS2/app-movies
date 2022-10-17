import 'package:app_filmes/checahem_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _nomeController = TextEditingController();
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
        appBar: AppBar(title: const Text(''),backgroundColor: Colors.transparent, elevation: 0),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35, top: 130),
              child: const Text(
                "Cadastrar",
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
                child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.5,
                  right: 35,
                  left: 35),
              child: Column(children: [
                TextField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: 'Nome',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
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
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Cadastrar',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff4c505b),
                      ),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xff4c505b),
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () {
                          cadastra();
                        },
                        icon: Icon(Icons.arrow_forward),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
              ]),
            ))
          ],
        ),
      ),
    );

    // return Scaffold(
    //     appBar: AppBar(
    //       title: Text("Cadastro Usuário"),
    //     ),
    //     body: ListView(
    //       padding: EdgeInsets.all(12),
    //       children: [
    //         TextFormField(
    //           controller: _nomeController,
    //           decoration: InputDecoration(label: Text("Nome")),
    //         ),
    //         TextFormField(
    //           controller: _emailController,
    //           decoration: InputDecoration(label: Text("E-mail")),
    //         ),
    //         TextFormField(
    //           controller: _passwordController,
    //           decoration: InputDecoration(label: Text("Senha")),
    //         ),
    //         ElevatedButton(
    //             onPressed: () {
    //               cadastra();
    //             },
    //             child: Text("Cadastrar"))
    //       ],
    //     ));
  }

  navegar() {
    print('escutou amigos');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (builder) => const LoginPage()));
  }

  cadastra() async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);

      if (userCredential != null) {
        userCredential.user!.updateDisplayName(_nomeController.text);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const ChecagemPage()),
            (Route<dynamic> route) => false);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code.toString() == "weak-password") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Ops! Crie uma senha mais forte'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height - 100,
              right: 20,
              left: 20),
        ));
      } else if (e.code.toString() == "email-already-in-use") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Ops! Este email já foi cadastrado'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height - 100,
              right: 20,
              left: 20),
        ));
      }
    }
  }
}
