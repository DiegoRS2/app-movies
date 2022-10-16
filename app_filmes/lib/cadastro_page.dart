import 'package:app_filmes/checahem_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cadastro Usuário"),
        ),
        body: ListView(
          padding: EdgeInsets.all(12),
          children: [
            TextFormField(
              controller: _nomeController,
              decoration: InputDecoration(label: Text("Nome")),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(label: Text("E-mail")),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(label: Text("Senha")),
            ),
            ElevatedButton(
                onPressed: () {
                  cadastra();
                },
                child: Text("Cadastrar"))
          ],
        ));
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
      if(e.code.toString() == "weak-password"){
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Ops! Crie uma senha mais forte'),
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
      
      else if(e.code.toString() == "email-already-in-use"){
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Ops! Este email já foi cadastrado'),
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
