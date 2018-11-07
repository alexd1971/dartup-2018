import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'src/components/video_movies_list/video_movies_list.dart';

@Component(
  selector: 'my-app',
  styleUrls: [
    'package:angular_components/app_layout/layout.scss.css',
    'app_component.css'
  ],
  templateUrl: 'app_component.html',
  directives: [
    MaterialButtonComponent,
    MaterialIconComponent,
    VideoMoviesList,
    MaterialDialogComponent,
    ModalComponent
  ],
  providers: [overlayBindings],
)
class AppComponent {
  bool showBasicDialog = false;
}
