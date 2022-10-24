import 'package:app_filmes/Util/text.dart';
import 'package:app_filmes/description.dart';
import 'package:flutter/material.dart';

class TrendingMovies extends StatelessWidget {
  final List trending;

  const TrendingMovies({super.key, required this.trending});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Modifica_texto(text: 'Filmes', color: Colors.white, size: 26),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 270,
          child: ListView.builder(
              itemCount: trending.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Description(
                                name: trending[index]['title'],
                                description: trending[index]['overview'],
                                // ignore: prefer_interpolation_to_compose_strings
                                bannerUrl: 'https://image.tmdb.org/t/p/w500'+trending[index]['backdrop_path'],
                                // ignore: prefer_interpolation_to_compose_strings
                                posterUrl: 'https://image.tmdb.org/t/p/w500'+ trending[index]['poster_path'],
                                vote: trending[index]['vote_average'].toString(),
                                launch_on: trending[index]['relase_date'])));
                  },
                  child: 
                  trending[index]['title'] != null ?
                  Container(
                    width: 140,
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      'https://image.tmdb.org/t/p/w500' +
                                          trending[index]['poster_path']))),
                        ),
                        Container(
                          child: Modifica_texto(
                            text: trending[index]['title'] ?? 'Loading',
                            color: Colors.white,
                            size: null,
                          ),
                        )
                      ],
                    ),
                  ): Container(

                  ),
                );
              }),
        )
      ]),
    );
  }
}
