// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';

import 'Util/text.dart';

class Description extends StatelessWidget {
  final String name, description, bannerUrl, posterUrl, vote, launch_on;

  const Description({super.key, required this.name, required this.description, required this.bannerUrl, required this.posterUrl, required this.vote, required this.launch_on});

  @override
  void initState() {    
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
       appBar: AppBar(
        elevation: 0.0,
            title: const Text(''),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(360)),
            backgroundColor: Colors.transparent,
            ),
     backgroundColor: Colors.black,
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
                    child: Modifica_texto(text: 'average rating ⭐' + vote, color: Colors.white, size: 18))
                ],
              ),
            ),
            SizedBox(height: 15,),
            Container(padding: EdgeInsets.all(10),
            child: Modifica_texto(text: name!= null? name : 'Not Loaded', color: Colors.white, size: 24,),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Modifica_texto(text:'Release of date: '+  launch_on, size: 14, color: Colors.white,),
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
    
          //return formatDate(DateTime(_date), [dd, '/', mm, '/', yyyy]);
       }
}