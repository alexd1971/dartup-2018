import 'package:rest_api_server/annotations.dart';

import 'resources/video_movies.dart';

class Api {
  final VideoMovies _videoMovies;

  Api(VideoMovies videoMovies)
    : _videoMovies = videoMovies;

  @Resource(path: 'videomovies')
  VideoMovies get videoMovies => _videoMovies;
}