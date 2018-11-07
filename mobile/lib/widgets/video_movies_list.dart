import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:models/models.dart' as models;
import 'package:video_movies_client/video_movies_client.dart';
import 'video_movie_details.dart';

class VideoMovieList extends StatefulWidget {
  
  final String title;
  final VideoMoviesClient videoMoviesClient;

  VideoMovieList({Key key, this.title, @required this.videoMoviesClient}) : super(key: key);

  @override
  _VideoMovieListState createState() => new _VideoMovieListState();
}

class _VideoMovieListState extends State<VideoMovieList> {

  int itemCount = 0;
  int pageSize = 10;
  Map<int, models.VideoMovie> videoMoviesCache = {};
  Map<models.ImdbId, models.VideoMovieDetails> detailsCache = {};

  @override
  initState() {
    super.initState();
    Future.wait([
      widget.videoMoviesClient.count(),
      widget.videoMoviesClient.read({'limit': '$pageSize'})
    ]).then((results) {
      setState(() {
        itemCount = results[0];
        List<models.VideoMovie> videoMovies = results[1];
        for (int i = 0; i < videoMovies.length; i++) {
          videoMoviesCache.addAll({
            i: videoMovies[i]
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: Icon(Icons.functions),
        title: new Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) => AlertDialog(
                  title: Text('About this application'),
                  content: Text('This is the mobile app of full stack sample in Dart. '
                                'It demonstrates using of common packages in Flutter.'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Close'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }
                    )
                  ],
                )
              );
            },
          )
        ]
      ),
      body: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          if (videoMoviesCache.keys.contains(index)) {
            final movie = videoMoviesCache[index];
            return Container(
              child: ListTile(
                title: Text(movie.title),
                subtitle: Text('${movie.year}'),
                onTap: () async {
                  final details = await _getDetails(movie.imdb);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => VideoMovieDetails(details)
                  ));
                },
              ),
              decoration: BoxDecoration(
                border: BorderDirectional(
                  bottom: BorderSide(
                    color: Theme.of(context).dividerColor
                  )
                )
              ),
            );
          }
          _loadItems(index);
          return ListTile(
            title: Text('Loading...'),
          );
        },
      ),
    );
  }

  _loadItems(int index) async {
    int skip = 0;
    List<int> indexList = videoMoviesCache.keys.toList()..sort();
    if (index < indexList.first) skip = max(indexList.first - pageSize, 0);
    if (index > indexList.last) skip = indexList.last;
    List<models.VideoMovie> movies = await widget.videoMoviesClient.read({
      'skip': '$skip',
      'limit': '$pageSize'
    });
    setState(() {
      for (int i = 0; i < movies.length; i++) {
        videoMoviesCache.addAll({
          skip+i: movies[i]
        });
      }          
    });
  }

  Future<models.VideoMovieDetails> _getDetails(models.ImdbId imdbId) async {
    if (detailsCache.containsKey(imdbId)) return detailsCache[imdbId];
    final details = await widget.videoMoviesClient.details(imdbId);
    if (details != null) detailsCache[imdbId] = details;
    return details ?? models.VideoMovieDetails();
  }
}