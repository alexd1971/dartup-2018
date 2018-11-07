import 'dart:async';
import 'package:rest_api_server/annotations.dart';
import 'package:api/collections.dart';
import 'package:models/models.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'video_movie_details.dart' as resource ;

class VideoMovies {
  VideoMoviesCollection videoMoviesCollection;
  resource.VideoMovieDetails _videoMovieDetails;

  VideoMovies(this.videoMoviesCollection, this._videoMovieDetails);

  @Get(path: '')
  Future<List<VideoMovie>> find(int skip, int limit) {
    mongo.SelectorBuilder query = mongo.where;
    if (skip != null) query = query.skip(skip);
    if (limit != null) query = query.limit(limit);
    return videoMoviesCollection.find(query).toList();
  }

  @Get(path: '{movieId}')
  Future<VideoMovie> findOne(String movieId) => videoMoviesCollection.findOne(MovieId(movieId));

  @Get(path: 'count')
  Future<int> count() => videoMoviesCollection.count();

  @Resource()
  resource.VideoMovieDetails get videoMovieDetails => _videoMovieDetails;
}