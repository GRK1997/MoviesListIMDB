import 'package:flutter/foundation.dart';
import 'package:movieslist/models/movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class SearchMovies extends ChangeNotifier {
  List<Movie> moviesList;
  List<Movie> getListMovies() => moviesList;

  updateMovies(String query) async {
    if (moviesList != null) moviesList = null;
    notifyListeners();
    if (query == "") query = "Avengers";

    Iterable<dynamic> movies;
    final response = await http
        .get("http://www.omdbapi.com/?s=" + query + "&apikey=f96c7179");

    // if (!mounted) return;
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      movies = result["Search"];
      // print(result["Search"]);
      print(movies);
      if (movies != null) {
        moviesList = movies.map((movie) => Movie.fromJson(movie)).toList();
        if (moviesList != null)
          for (int i = 0; i < moviesList.length; i++) {
            await moviesList[i].setMovieDetails();
          }
      }
    }

    notifyListeners();
  }
}
