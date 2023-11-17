import 'package:flutter/material.dart';
import 'package:hello_world/models/movie.dart';
import 'package:hello_world/screens/details.dart';

class MovieRow extends StatelessWidget {
  const MovieRow({super.key, required this.movieList, required this.title});

  final List<Result> movieList;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        Container(
          height: 200,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movieList.length,
              itemBuilder: ((context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsPage(
                                  title: title,
                                  movieid: movieList[index].id!,
                                  movieTitle: movieList[index].title!,
                                  poster: movieList[index].posterPath!,
                                )));
                  },
                  child: Column(
                    children: [
                      Hero(
                        tag: "$title-${movieList[index].id}",
                        child: Image(
                          width: 100,
                          height: 150,
                          image: NetworkImage(
                              'http://image.tmdb.org/t/p/w500${movieList[index].posterPath}'),
                        ),
                      ),
                      Text('${movieList[index].title}')
                    ],
                  ),
                );
              })),
        ),
      ],
    );
  }
}
