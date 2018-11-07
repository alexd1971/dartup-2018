import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:models/models.dart' as models;
import 'package:web/src/components/page_selector/page_selector.dart';
import 'package:web/src/components/video_movie_details/video_movie_details.dart';

import 'package:web/src/services/video_movies_client.dart';

@Component(
  selector: 'video-movies-list',
  styleUrls: ['video_movies_list.css'],
  templateUrl: 'video_movies_list.html',
  directives: [
    MaterialExpansionPanel,
    MaterialExpansionPanelAutoDismiss,
    NgFor,
    PageSelector,
    VideoMovieDetails
  ],
  providers: [
    overlayBindings,
    const ClassProvider(VideoMoviesClientWeb),
  ],
)
class VideoMoviesList implements OnInit {

  final VideoMoviesClientWeb videoMoviesClient;

  VideoMoviesList(this.videoMoviesClient);

  List<models.VideoMovie> videoMovies = [];



  @ViewChild(PageSelector)
  PageSelector pageSelector;

  int pageSize = 10;

  loadPage(int page) async {
    videoMovies = await videoMoviesClient.read({
      'skip': '${(pageSelector.activePage - 1) * pageSize}',
      'limit': '$pageSize'
    });
  }

  @override
  Future ngOnInit() async {
    int itemCount = await videoMoviesClient.count();
    int pageCount = (itemCount/pageSize).ceil();
    pageSelector.pageCount = pageCount;
    await loadPage(1);
  }
}
