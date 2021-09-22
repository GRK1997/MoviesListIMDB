import 'package:http/http.dart' as http;
import 'dart:convert';
 
  class Movie  {
  final String imdbId; 
  final String poster; 
  final String title; 
  final String year; 
  String rating;
  String runtime;
  String genre;
  String directors;
  String writer;
  String actors;
  String plot;
  String country;
  String language;
  List<dynamic> ratingsOther=List<dynamic>();
  Movie({this.imdbId, this.title, this.poster, this.year}); 
  setMovieDetails()async
{
// movieDetails.clear();
 // print("Id:"+this.imdbId.toString());
var movies;
    final response =  await http
        .get("http://www.omdbapi.com/?i=" + this.imdbId + "&apikey=f96c7179");

    // if (!mounted) return;
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      movies = result;
     // print("MovieData: "+movies.toString());
      this.rating=movies["imdbRating"];
      this.runtime=movies["Runtime"];
      this.genre=movies["Genre"];
      this.actors=movies["Actors"];
      this.country=movies["Country"];
      this.directors=movies["Director"];
      this.plot=movies["Plot"];
      this.writer=movies["Writer"];
      this.ratingsOther=movies["Ratings"];
      this.language=movies["Language"];
  
    }
}

   factory Movie.fromJson(Map<String, dynamic> json) {
    
    return Movie(
      imdbId: json["imdbID"], 
      poster: json["Poster"], 
      title: json["Title"], 
      year: json["Year"],
    );
  }

}