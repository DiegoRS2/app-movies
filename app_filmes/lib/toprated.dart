import 'package:app_filmes/Util/text.dart';
import 'package:flutter/material.dart';

class TopRated extends StatelessWidget {
  final List topRated;

  const TopRated({super.key, required this.topRated});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Modifica_texto(text: 'Séries', color: Colors.white, size: 26),
        const SizedBox(height: 10,),
        Container(
          height: 270,
          child: ListView.builder(
              itemCount: topRated.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
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
                                      'https://image.tmdb.org/t/p/w500' +
                                          topRated[index]['poster_path']))),
                        ),
                        Container(
                          child: Modifica_texto(
                            text: topRated[index]['title'] ?? 'Loading',
                            color: Colors.white, 
                            size: null,),
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
