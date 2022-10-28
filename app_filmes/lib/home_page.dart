import 'package:app_filmes/Util/text.dart';
import 'package:app_filmes/toprated.dart';
import 'package:app_filmes/trending.dart';
import 'package:app_filmes/tv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'carrossel.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List trendingMovies = [];
  List topRatedMovies = [];
  List tv = [];
  final String apiKey = "da0ed4da9271f685d8c63b7abe718f98";
  final readAcessToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkYTBlZDRkYTkyNzFmNjg1ZDhjNjNiN2FiZTcxOGY5OCIsInN1YiI6IjYzNTQyNjIzYzlkYmY5MDA3ZjAyN2EyMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.3QSmpu2mMICaV3iEgIGa7vdg8zZIkJAumSkdRsavWmo";

  loadMovies() async {
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apiKey, readAcessToken),
        logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true));
    Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map top = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map televisao = await tmdbWithCustomLogs.v3.tv.getPopular();
    setState(() {
      trendingMovies = trendingresult['results'];
      topRatedMovies = top['results'];
      tv = televisao['results'];
    });
  }

  final _firebaseAuth = FirebaseAuth.instance;
  String nome = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    loadMovies();
    print(tv);
    pegarUsuario();
  }

  @override
  Widget build(BuildContext context) {
    pegarUsuario();
    return Scaffold(
        backgroundColor: Colors.black,
        drawer: Drawer(
          backgroundColor: Colors.black,
          child: ListView(children: [
            UserAccountsDrawerHeader(
                accountName: Text(nome), accountEmail: Text(email)),
            ListTile(
              dense: true,
              title: const Modifica_texto(
                text: 'Exit',
                color: Colors.white,
                size: null,
              ),
              trailing: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onTap: () {
                sair();
              },
            )
          ]),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Modifica_texto(
            text: 'Movies 🍿',
            color: null,
            size: null,
          ),
        ),
        body: ListView(
          children: [
            const Padding(
                padding: EdgeInsets.all(15),
                child: Modifica_texto(
                    text: "Future releases", color: Colors.white, size: 20)),
            const Carrossel(),
            TopRated(topRated: topRatedMovies),
            TV(tv: tv),
            TrendingMovies(trending: trendingMovies)
          ],
        ));
  }

  pegarUsuario() async {
    User? user = await _firebaseAuth.currentUser;
    if (user != null) {
      setState(() {
        nome = user.displayName!;
        email = user.email!;
      });
    }
  }

  sair() async {
    await _firebaseAuth.signOut().then((user) => null);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (builder) => const LoginPage()));
  }
}
