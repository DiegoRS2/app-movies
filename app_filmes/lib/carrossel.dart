import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carrossel extends StatefulWidget {
  const Carrossel({super.key});

  

  @override
  State<Carrossel> createState() => _CarrosselState();
}
   final List<String> imageList = [
    "https://cinearaujo.com.br/filmes/filme3225_cp.jpg",
     "https://midias.correiobraziliense.com.br/_midias/jpg/2022/04/28/675x450/1_avatar_2_the_way_of_water_750x422-7860855.jpg?20220428103146?20220428103146",
     "https://media.fstatic.com/y_5WTB_fBi_xGPywqC1rICpubCk=/268x386/smart/media/movies/covers/2021/09/FAJU9EJUYAgCV6L.jpg",
   ];


class _CarrosselState extends State<Carrossel> {
  @override
  Widget build(BuildContext context) {

    return 
    CarouselSlider(
            options: CarouselOptions(
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              autoPlay: true,
            ),
            items: imageList.map((e) => ClipRRect(
             borderRadius: BorderRadius.circular(8),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.network(e,
                  width: 1050,
                  height: 350,
                  fit: BoxFit.cover,
                  
                  ),
                ],
              ) ,
            )).toList(),
  );}
}

