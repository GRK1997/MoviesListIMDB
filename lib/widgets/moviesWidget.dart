import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movieslist/models/SearchMovies.dart';
import 'package:movieslist/models/movie.dart';
import 'search_widget.dart';

import 'package:provider/provider.dart';

class MoviesWidget extends StatefulWidget {
  @override
  _MoviesWidgetState createState() => _MoviesWidgetState();
}

class _MoviesWidgetState extends State<MoviesWidget> {
  Iterable movies;
  String query = 'Superman';
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

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Search for Movies',
        onChanged: searchMovie,
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

                        return Card(
                          elevation: 2,
                          child: ListTile(
                              title: Row(
                            children: [
                              SizedBox(
                                  width: 100,
                                  child: ClipRRect(
                                    child: Image.network(movie.poster),
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(movie.title),
                                      Text(movie.year)
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )),
                        );
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
