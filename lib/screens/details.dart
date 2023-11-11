import 'package:flutter/material.dart';
import 'package:hello_world/api/cast.dart';
import 'package:hello_world/models/cast.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage(
      {super.key, required this.movieid, required this.movieTitle});

  final int movieid;
  final String movieTitle;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
    getCast();
  }

  List<Cast> castList = [];

  getCast() async {
    castList = await getCastAPI(widget.movieid);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.movieTitle)),
      body: Center(
          child: castList.isEmpty
              ? const CircularProgressIndicator()
              : ListView.builder(itemBuilder: ((context, index) {
                  return CircleAvatar(
                    backgroundImage: NetworkImage(
                        'http://image.tmdb.org/t/p/w500${castList[index].profilePath}'),
                  );
                }))),
    );
  }
}
