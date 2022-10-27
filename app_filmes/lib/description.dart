// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:date_format/date_format.dart';

import 'package:flutter/material.dart';

import 'Util/text.dart';

class Description extends StatelessWidget {
  final String name, description, bannerUrl, posterUrl, vote, launch_on;

  const Description({super.key, required this.name, required this.description, required this.bannerUrl, required this.posterUrl, required this.vote, required this.launch_on});

  @override
  void initState() {
      print(name);
      print(description);
      print(bannerUrl);
      print(vote);
    
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.black,
      //  appBar: AppBar(
      //       title: const Text(''),
      //       backgroundColor: Colors.transparent,
      //       ),
      body: Container(
        child: ListView(
          children: [
            Container(
              height: 250,
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(bannerUrl, fit: BoxFit.cover,),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    child: Modifica_texto(text: 'classificação média ⭐' + vote, color: Colors.white, size: 18))
                ],
              ),
            ),
            SizedBox(height: 15,),
            Container(padding: EdgeInsets.all(10),
            child: Modifica_texto(text: name!= null? name : 'Not Loaded', color: Colors.white, size: 24,),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Modifica_texto(text:'Data de lançamento - '+  launch_on, size: 14, color: Colors.white,),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  height: 200,
                  width: 100,
                  child: Image.network(posterUrl),
                ),
                Flexible(
                  child: Modifica_texto(
                    text: description, size: 18, color: Colors.white,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
       getFormatedDate(_date) {
          return formatDate(DateTime(_date), [dd, '/', mm, '/', yyyy]);
       }
}