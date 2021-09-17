import 'package:flutter/foundation.dart';
import 'package:movieslist/models/movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchMovies extends ChangeNotifier {
  List<Movie> moviesList;
  List<Movie> getListMovies() => moviesList;

  updateMovies(String query) async {
    if (query=="")
    {
      moviesList=[];
      notifyListeners();
    }
    else
    {
    Iterable<dynamic> movies;
    final response = await http
        .get("http://www.omdbapi.com/?s=" + query + "&apikey=f96c7179");

    // if (!mounted) return;
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      movies = result["Search"];
      print(movies);
      moviesList = movies.map((movie) => Movie.fromJson(movie)).toList();
    }
    notifyListeners();
    }
  }
}