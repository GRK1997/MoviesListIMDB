import 'package:flutter/material.dart';
import 'package:movieslist/models/Colors.dart';
import 'package:movieslist/models/movie.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailsScreen extends StatefulWidget {
  final Movie movie;
  DetailsScreen({this.movie});

  @override
  _DetailsScreen createState() => _DetailsScreen();
}

class _DetailsScreen extends State<DetailsScreen> {
  Map<int, String> directorsvalues;
  Map<int, String> writervalues;
  Map<int, String> actorsvalues;
  void splitNames() {
//directors
    final directors = widget.movie.directors;
    final directorssplit = directors.split(',');
    directorsvalues = {
      for (int i = 0; i < directorssplit.length; i++) i: directorssplit[i]
    };
//Writer
    final writer = widget.movie.writer;
    final writersplit = writer.split(',');
    writervalues = {
      for (int i = 0; i < writersplit.length; i++) i: writersplit[i]
    };
//Actors
    final actors = widget.movie.actors;
    final actorssplit = actors.split(',');
    actorsvalues = {
      for (int i = 0; i < actorssplit.length; i++) i: actorssplit[i]
    };
  }

  @override
  void initState() {
    splitNames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 10 * 9;
    return Scaffold(
      backgroundColor: color1,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: height,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 10 * 13,
                    decoration: BoxDecoration(
                      color: color1.withOpacity(0.8),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(widget.movie.poster),
                        // colorFilter: ColorFilter.mode(color1.withOpacity(0.4), BlendMode.hue)
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                          color1,
                          color1.withOpacity(1),
                          color1.withOpacity(0.2)
                        ])),
                  ),
                  Positioned(
                    top: 230,
                    left: 30,
                    child: Container(
                      width: 300,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.movie.title,
                            style: TextStyle(color: color5, fontSize: 40),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 120),
                            child: Text(
                              widget.movie.genre,
                              style: TextStyle(
                                  color: color5.withOpacity(0.4), fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 380,
                    left: 30,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: color2,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14))),
                              child: Icon(
                                Icons.arrow_downward,
                                color: color5,
                                size: 30,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 60, right: 60),
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: color2,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14))),
                              child: Image.asset("Assets/Path-1.png"),
                              padding: EdgeInsets.all(12),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: color2,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14))),
                              child: Image.asset("Assets/Path.png"),
                              padding: EdgeInsets.all(12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 470,
                    left: 23,
                    child: Container(
                      height: 200,
                      width: 350,
                      decoration: BoxDecoration(
                          color: color2,
                          borderRadius: BorderRadius.all(Radius.circular(14))),
                      child: Container(
                        padding: EdgeInsets.only(top: 25, left: 25, right: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              //  crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 10),
                                  width: 150,
                                  child: RatingBar.builder(
                                    ignoreGestures: true,
                                    maxRating: 10,
                                    itemSize: 20,
                                    initialRating:
                                        double.parse(widget.movie.rating),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 100.0),
                                  child: Text(
                                    widget.movie.rating,
                                    style: TextStyle(
                                        color: Colors.amber, fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Text(
                                widget.movie.ratingsOther[0]["Source"] +
                                    "    " +
                                    widget.movie.ratingsOther[0]["Value"],
                                style: TextStyle(
                                    color: color5.withOpacity(0.5),
                                    fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Text(
                                widget.movie.ratingsOther[1]["Source"] +
                                    "                  " +
                                    widget.movie.ratingsOther[1]["Value"],
                                style: TextStyle(
                                    color: color5.withOpacity(0.5),
                                    fontSize: 20),
                              ),
                            ),
                            Text(
                              widget.movie.ratingsOther[2]["Source"] +
                                  "                           " +
                                  widget.movie.ratingsOther[2]["Value"],
                              style: TextStyle(
                                  color: color5.withOpacity(0.5), fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Container(
                //padding: EdgeInsets.only(bottom: 40),
                height: 200,
                width: 350,
                decoration: BoxDecoration(
                    color: color2,
                    borderRadius: BorderRadius.all(Radius.circular(14))),
                child: Container(
                  padding: EdgeInsets.only(top: 12, left: 20, right: 20),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Row(
//mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                padding: EdgeInsets.only(right: 20),
                                child: Image.asset(
                                  "Assets/Group 356.png",
                                  width: 25,
                                )),
                            Flexible(
                                child: Text(
                              widget.movie.year,
                              style: TextStyle(
                                  color: color5.withOpacity(.5), fontSize: 20),
                            ))
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            Container(
                                padding: EdgeInsets.only(right: 20),
                                child: Image.asset(
                                  "Assets/Group 357.png",
                                  width: 25,
                                )),
                            Flexible(
                                child: Text(
                              widget.movie.country,
                              style: TextStyle(
                                  color: color5.withOpacity(.5), fontSize: 20),
                            ))
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            Container(
                                padding: EdgeInsets.only(right: 20),
                                child: Image.asset(
                                  "Assets/Group 358.png",
                                  width: 25,
                                )),
                            Flexible(
                                child: Text(
                              widget.movie.runtime,
                              style: TextStyle(
                                  color: color5.withOpacity(.5), fontSize: 20),
                            ))
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                                padding: EdgeInsets.only(right: 20),
                                child: Image.asset(
                                  "Assets/Vector.png",
                                  width: 25,
                                )),
                            Flexible(
                                child: Text(
                              widget.movie.language,
                              style: TextStyle(
                                  color: color5.withOpacity(.5), fontSize: 20),
                            ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                child: Center(
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                   // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                         
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Plot",style: TextStyle(color: color5,fontSize: 25),),
                            SizedBox(height: 5,),
                            Text(
                             '"'+ widget.movie.plot+'"',
                              style: TextStyle(
                                  color: color5.withOpacity(.5),
                                  fontSize: 16),
                            )
                          ],
                        ),
                      ),
                      Container(
                         padding: EdgeInsets.all(20),
                        height: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Directors",style: TextStyle(color: color5,fontSize: 25),),
                            Expanded(
                            
                              child: ListView.builder(
                                
                                padding: EdgeInsets.only( right: 50, top: 10),
                                  itemCount: directorsvalues.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          right: 50, top: 10),
                                      child: Container(
                                        height: 30,
                                        //width: 0,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(.1),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),

                                        child: Center(
                                            child: Text(
                                          directorsvalues[index],
                                          style: TextStyle(
                                              color: color5.withOpacity(.5)),
                                        )),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                      Container(
                         padding: EdgeInsets.all(20),
                        height: 250,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Actors",style: TextStyle(color: color5,fontSize: 25),),
                            Flexible(
                             // fit: FlexFit.loose,
                              child: ListView.builder(
                                  itemCount: actorsvalues.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top:5,right: 70,bottom: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(6)
                                        ),
                                        height: 30,
                                        width: 50,
                                        child: 
                                           Center(child: Text(actorsvalues[index],style: TextStyle(
                                                color: color5.withOpacity(.5)),)),
                                       
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                      Container(
                         padding: EdgeInsets.all(20),
                        height: 200,
                        child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Writers",style: TextStyle(color: color5,fontSize: 25),),
                            Flexible(
                              fit: FlexFit.loose,
                              child: ListView.builder(
                                padding: EdgeInsets.only(right: 25),
                                  itemCount: writervalues.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(top:5,right: 50,bottom: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(6)
                                        ),
                                        height: 30,
                                        width: 50,
                                        child: 
                                           Center(child: Text(writervalues[index],style: TextStyle(
                                                color: color5.withOpacity(.5)),)),
                                        
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                //   height: 200,
                width: 350,
                decoration: BoxDecoration(
                    color: color2,
                    borderRadius: BorderRadius.all(Radius.circular(14))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
