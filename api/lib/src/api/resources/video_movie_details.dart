import 'dart:async';
import 'package:rest_api_server/annotations.dart';
import 'package:api/collections.dart';
import 'package:models/models.dart' as models;
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class VideoMovieDetails {
  VideoMovieDetailsCollection videoMovieDetailsCollection;
  VideoMovieDetails(this.videoMovieDetailsCollection);

  @Get(path: '{imdbId}/details')
  Future<models.VideoMovieDetails> find(String imdbId) async {
    mongo.SelectorBuilder query = mongo.where.eq('imdb.id', imdbId);
    final results = await videoMovieDetailsCollection.find(query).toList();
    return results?.first;
  }
}