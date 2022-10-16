import 'package:app_filmes/checahem_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
final _firebaseAuth = FirebaseAuth.instance;
String nome = '';
String email = '';

@override
void initState() {
    pegarUsuario();
      
  }

  @override
  Widget build(BuildContext context) {
    pegarUsuario();
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(accountName: Text(nome), accountEmail: Text(email)),
            ListTile(
              dense: true,
              title: Text('Sair'),
              trailing: Icon(Icons.exit_to_app),
              onTap: (){
                sair();
              },
            )
          ]
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
         
        ],
      ),
    );
  }
  pegarUsuario() async {
    User? user = await _firebaseAuth.currentUser;
    if(user != null){
      setState(() {
        nome = user.displayName!;
        email = user.email!;
      });
    }
  }


  sair() async{
    await _firebaseAuth.signOut().then((user) => null);
     Navigator.pushReplacement(context, 
        MaterialPageRoute(
        builder: (builder)=> const ChecagemPage()));
  }
}
