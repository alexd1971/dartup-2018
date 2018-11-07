import 'package:angular/angular.dart';
import 'package:models/models.dart' as models;
import 'package:web/src/services/video_movies_client.dart';

@Component(
  selector: 'video-movie-details',
  templateUrl: 'video_movie_details.html',
  styleUrls: [
    'video_movie_details.css'
  ],
  pipes: [
    DatePipe
  ]
)
class VideoMovieDetails {

  VideoMoviesClientWeb _videoMoviesClient;

  VideoMovieDetails(this._videoMoviesClient);

  @Input()
  models.ImdbId imdbId;

  models.VideoMovieDetails details;

  load() async {
    if (details == null) {
      details = await _videoMoviesClient.details(imdbId);
    }
  }
}