import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/screens/details.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFromFirestore();
  }

  var favMoviesList = [];

  getDataFromFirestore() async {
    final favmovies =
        await FirebaseFirestore.instance.collection('watchlist').get();
    // print(data);
    favMoviesList = favmovies.docs;

    for (var doc in favmovies.docs) {
      print(doc.data());
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("FAV MOVIES"),
        ),
        body: ListView.builder(
            itemCount: favMoviesList.length,
            itemBuilder: ((context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsPage(
                                title: favMoviesList[index].data()['title'],
                                movieid: favMoviesList[index].data()['id'],
                                movieTitle: "test",
                                poster: favMoviesList[index].data()['poster'],
                              )));
                },
                child: Card(
                  child: Image(
                      height: 150,
                      width: 200,
                      image: NetworkImage(
                          "http://image.tmdb.org/t/p/w500${favMoviesList[index].data()['poster']}")),
                ),
              );
            })));
  }
}
