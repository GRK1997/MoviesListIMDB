
import 'package:flutter/material.dart';
import 'package:movieslist/models/SearchMovies.dart';
import 'package:movieslist/models/movie.dart';
import 'package:movieslist/widgets/moviesWidget.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override 
  _App createState() => _App(); 
}

class _App extends State<App> {

  List<Movie> _movies = new List<Movie>(); 

  @override
  void initState() {
    super.initState(); 
  
  }

 


  

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      
      title: "Movies App",
      home: Scaffold(
        appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      //extendBodyBehindAppBar: true,
        body:ChangeNotifierProvider(
          create: (context)=>SearchMovies(),
          child: MoviesWidget()),
         
      )
    );
    
  }
}
