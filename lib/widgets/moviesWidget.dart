import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movieslist/models/Colors.dart';
import 'package:movieslist/models/SearchMovies.dart';
import 'package:movieslist/widgets/DetailsScreen.dart';
//import 'package:movieslist/models/movie.dart';
import 'search_widget.dart';

import 'package:provider/provider.dart';

class MoviesWidget extends StatefulWidget {
 
  @override
  _MoviesWidgetState createState() => _MoviesWidgetState();
}

class _MoviesWidgetState extends State<MoviesWidget> {
  
  Iterable movies;
  String query = 'Avengers';
  Timer debouncer;
  SearchMovies moviesData;
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (t) {
      moviesData = Provider.of<SearchMovies>(context, listen: false);
      if (moviesData.moviesList == null) {
        moviesData.updateMovies(query);
      }
    });

    super.initState();
  }

  Widget buildSearch() => Padding(
        padding: const EdgeInsets.only(top: 35.0),
        child: SearchWidget(
          text: query,
          hintText: 'Search for Movies',
          onChanged: searchMovie,
          
        ),
      );

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1),
  }) {
    if (debouncer != null) {
      debouncer.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future searchMovie(String query) async => debounce(() async {
        if (!mounted) return;
       
         moviesData.updateMovies(query);

        //Navigator.pop(context);
      });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildSearch(),
        Consumer<SearchMovies>(
          builder: (context, data, child) {
            return Expanded(
              child: data.getListMovies() != null
                  ? ListView.builder(
                      itemCount: data.getListMovies().length,
                      itemBuilder: (context, index) {
                        final movie = data.getListMovies()[index];
                        //  print("Widget Data"+movie.rating.toString());
                        if(data!=null)
                        {
                        return Container(
                          padding: EdgeInsets.only(bottom: 20),
                          width: 200,
                          child: ListTile(
                              title: Column(
                            children: [
                              Stack(
                                //fit: StackFit.expand,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailsScreen(
                                                  movie: movie,
                                                )),
                                      );
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              10 *
                                              2.8,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                        image: DecorationImage(
                                          fit: BoxFit.fitWidth,
                                          image: NetworkImage(movie.poster),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 15.4,
                                    left: 10,
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: color5,
                                            size: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 4.0),
                                            child: Text(
                                              movie.rating.toString() + "/10",
                                              style: TextStyle(
                                                  color: color5, fontSize: 15),
                                            ),
                                          )
                                        ],
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              10 *
                                              .4,
                                      width: MediaQuery.of(context).size.width /
                                          10 *
                                          2,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.7),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 15, top: 5),
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movie.title,
                                      style: TextStyle(
                                          color: color5, fontSize: 20),
                                    ),
                                    //  Text(movie.year,style: TextStyle(color: color5,fontSize: 20),)
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 15, top: 8),
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      color: color3,
                                    ),
                                    Text("  " + movie.runtime.toString(),
                                        style: TextStyle(
                                          color: color3,
                                        )),
                                  ],
                                ),
                              )
                            ],
                          )),
                        );
                        }
                        else
                        return Center(child: CircularProgressIndicator());
                      })
                  : Center(child: CircularProgressIndicator()),
            );
          },
        )
        //: Text("Search For Movies In A Search Bar"),
      ],
    );
  }
}
