import 'package:app_filmes/Util/text.dart';
import 'package:flutter/material.dart';
import 'package:app_filmes/description.dart';

class TV extends StatelessWidget {
  final List tv;

  const TV({super.key, required this.tv});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Modifica_texto(
            text: 'TV shows', color: Colors.white, size: 26),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 270,
          child: ListView.builder(
              itemCount: tv.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                     Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Description(
                                name: tv[index]['name'],
                                description: tv[index]['overview'],
                                // ignore: prefer_interpolation_to_compose_strings
                                bannerUrl: 'https://image.tmdb.org/t/p/w500'+tv[index]['backdrop_path'],
                                // ignore: prefer_interpolation_to_compose_strings
                                posterUrl: 'https://image.tmdb.org/t/p/w500'+tv[index]['poster_path'],
                                vote: tv[index]['vote_average'].toString(),
                                launch_on: tv[index]['air_date'] == null ? "2013-05-19": tv[index]['air_date'])));
                  },
                  child: Container(
                    width: 140,
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      'https://image.tmdb.org/t/p/w500'+
                                          tv[index]['poster_path']))
                                          ),
                        ),
                        Container(
                          child: Modifica_texto(
                            text: tv[index]['name'] ?? 'Loading',
                            color: Colors.white,
                            size: null,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
        )
      ]),
    );
  }
}
