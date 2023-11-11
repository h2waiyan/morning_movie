import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hello_world/api/movie.dart';
import 'package:hello_world/components/movie_row.dart';
import 'package:hello_world/models/movie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPopularMovies();
  }

  List<Result> popList = [];
  List<Result> nowPlayingList = [];
  List<Result> upcomingList = [];
  List<Result> topRatedList = [];

  getPopularMovies() async {
    popList = await getMovie('popular');
    nowPlayingList = await getMovie('now_playing');
    upcomingList = await getMovie('upcoming');
    topRatedList = await getMovie('top_rated');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Awesome MovieDB")),
      body: Center(
        child: Column(children: [
          MovieRow(
            movieList: popList,
            title: "Popular Movies",
          ),
          MovieRow(
            movieList: nowPlayingList,
            title: "Now Playing Movies",
          ),
          MovieRow(
            movieList: upcomingList,
            title: "Upcoming Movies",
          ),
          MovieRow(
            movieList: topRatedList,
            title: "TopRated Movies",
          ),
        ]),
      ),
    );
  }
}
