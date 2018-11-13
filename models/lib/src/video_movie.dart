import 'package:data_model/data_model.dart';

class VideoMovie implements Model<MovieId> {

  MovieId id;
  String title;
  int year;
  ImdbId imdb;
  VideoType type;

  VideoMovie({
    this.id,
    this.title,
    this.year,
    this.imdb,
    this.type
  });

  factory VideoMovie.fromJson(Map<String, dynamic> json) =>
    json == null ? null : VideoMovie(
      id: MovieId(json['id']),
      title: json['title'],
      year: json['year'],
      imdb: ImdbId(json['imdb']),
      type: VideoType(json['type'])
    ); 

  Map<String, dynamic> get json => {
        'title': title,
        'year': year,
        'imdb': imdb.json,
        'type': type.json
      }..removeWhere((key, value) => value == null);
}

class MovieId extends ObjectId {
  MovieId._(String id):super(id);
  factory MovieId(String id) => id == null ? null : MovieId._(id);
}

class ImdbId extends ObjectId {
  ImdbId._(String id):super(id);
  factory ImdbId(String id) => id == null ? null : ImdbId._(id);
}

class VideoType implements JsonEncodable {

  static const movie = VideoType._('movie');

  final String _type;

  const VideoType._(this._type);

  factory VideoType(String type) => type == null ? null : VideoType._(type);

  String get json => _type;
}