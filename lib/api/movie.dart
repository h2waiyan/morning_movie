import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hello_world/models/movie.dart';
import 'package:http/http.dart' as http;

Future<List<Result>> getMovie(type) async {
  final dio = Dio();
  final response = await dio.get(
      "https://api.themoviedb.org/3/movie/$type?language=en-US&page=1&api_key=050c28541f900007285c3020069bfd62");
  // final response = await http.get(Uri.parse(
  //     'https://api.themoviedb.org/3/movie/$type?language=en-US&page=1&api_key=050c28541f900007285c3020069bfd62'));
  if (response.statusCode == 200) {
    var movieResult = MovieRespone.fromJson(response.data);
    // print(movieResult);
    return movieResult.results!;
  } else {
    print("HERE");
    throw Exception("Something wrong...");
  }
}
