import 'package:angular/angular.dart';
import 'package:rest_api_client/rest_api_client.dart';
import 'package:video_movies_client/video_movies_client.dart';
import 'package:http/browser_client.dart';

@Injectable()
class VideoMoviesClientWeb extends VideoMoviesClient {

  VideoMoviesClientWeb(): super(ApiClient(
    Uri.http('localhost:3333',''),
    BrowserClient()));
}