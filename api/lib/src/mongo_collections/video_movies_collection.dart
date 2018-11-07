import 'dart:async';
import 'package:rest_api_server/mongo_collection.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:models/models.dart';

class VideoMoviesCollection extends MongoCollection<VideoMovie, MovieId> {

  VideoMoviesCollection(mongo.DbCollection collection): super(collection);

  @override
    VideoMovie createModel(Map<String, dynamic> data) => VideoMovie.fromJson(data);

  Future<int> count([mongo.SelectorBuilder selector]) => collection.count(selector);
}