
import 'package:flutter/material.dart';
import 'package:movieslist/models/SearchMovies.dart';
import 'package:movieslist/models/movie.dart';
import 'package:movieslist/widgets/moviesWidget.dart';
import 'package:movieslist/models/Colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(App(
    
  ));
}

class App extends StatefulWidget {
  @override 
  _App createState() => _App(); 
}

class _App extends State<App> {


  @override
  void initState() {
    super.initState(); 
  
  }



  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Movies App",
      home: Scaffold(
      backgroundColor: color2,
      //extendBodyBehindAppBar: true,
        body:ChangeNotifierProvider(
          create: (context)=>SearchMovies(),
          child: MoviesWidget()),
         
      )
    );
    
  }
}
