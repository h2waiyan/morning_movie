import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/api/cast.dart';
import 'package:hello_world/models/cast.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage(
      {super.key,
      required this.movieid,
      required this.title,
      required this.movieTitle,
      required this.poster});

  final int movieid;
  final String movieTitle;
  final String poster;
  final String title;

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
      appBar: AppBar(
        title: Text(widget.movieTitle),
        actions: [
          IconButton(
              onPressed: () async {
                try {
                  final res = await FirebaseFirestore.instance
                      .collection('watchlist')
                      .add({
                    "id": widget.movieid,
                    "title": widget.movieTitle,
                    "poster": widget.poster,
                  });

                  print(res);
                } catch (e) {
                  print(e);
                }
              },
              icon: const Icon(Icons.favorite_outline))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 0.3,
            image:
                NetworkImage('http://image.tmdb.org/t/p/w500${widget.poster}'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: "${widget.title}-${widget.movieid}",
              child: Image(
                width: 200,
                height: 250,
                image: NetworkImage(
                    'http://image.tmdb.org/t/p/w500${widget.poster}'),
              ),
            ),
            const Text(
              "Casts",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            castList.isEmpty
                ? const CircularProgressIndicator()
                : Container(
                    height: 150,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: ((context, index) {
                          return CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                'http://image.tmdb.org/t/p/w500${castList[index].profilePath}'),
                          );
                        })),
                  ),
          ],
        ),
      ),
    );
  }
}
