import 'package:data_model/data_model.dart';
import 'video_movie.dart';

class VideoMovieDetails extends Model {
  String title;
  int year;
  DateTime released;
  int runtime;
  List<String> countries;
  List<String> genres;
  String director;
  List<String> writers;
  List<String> actors;
  String plot;
  String poster;
  ImdbData imdb;
  VideoType type;

  VideoMovieDetails({
    VideoDetailsId id,
    this.title,
    this.year,
    this.released,
    this.runtime,
    this.countries,
    this.genres,
    this.director,
    this.writers,
    this.actors,
    this.plot,
    this.poster,
    this.imdb,
    this.type
  }): super(id);

  factory VideoMovieDetails.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return VideoMovieDetails(
      id: VideoDetailsId(json['id']),
      title: json['title'],
      year: json['year'],
      released: json['released'] is DateTime ? json['released'] : DateTime.parse(json['released']).toLocal(),
      runtime: json['runtime'],
      countries: json['countries'] == null ? null : List<String>.from(json['countries']),
      genres: json['genres'] == null ? null : List<String>.from(json['genres']),
      director: json['director'],
      writers: json['writers'] == null ? null : List<String>.from(json['writers']),
      actors: json['actors'] == null ? null : List<String>.from(json['actors']),
      plot: json['plot'],
      poster: json['poster'],
      imdb: ImdbData.fromJson(json['imdb']),
      type: VideoType(json['type'])
    );
  }

  @override
  Map<String, dynamic> get json => super.json..addAll({
    'title': title,
    'year': year,
    'released': released.toUtc(),
    'runtime': runtime,
    'countries': countries,
    'genres': genres,
    'director': director,
    'writers': writers,
    'actors': actors,
    'plot': plot,
    'poster': poster,
    'imdb': imdb.json,
    'type': type
  })..removeWhere((key, value) => value == null);
}

class ImdbData implements JsonEncodable {
  ImdbId id;
  num rating;
  int votes;

  ImdbData({this.id, this.rating, this.votes});
  factory ImdbData.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return ImdbData(
      id: ImdbId(json['id']),
      rating: json['rating'],
      votes: json['votes']
    ); 
  }

  @override
  Map<String,dynamic> get json => {
    'id': id.json,
    'rating': rating,
    'votes': votes
  }..removeWhere((key,value) => value == null);
}

class VideoDetailsId extends ObjectId {

  VideoDetailsId._(id): super(id);
  factory VideoDetailsId(id) {
    if (id == null) return null;
    return VideoDetailsId._(id);
  }
}