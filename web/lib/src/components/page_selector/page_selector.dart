import 'dart:async';
import 'dart:math';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

@Component(
  selector: 'page-selector',
  templateUrl: 'page_selector.html',
  styleUrls: [
    'page_selector.css'
  ],
  directives: [
    MaterialButtonComponent,
    NgFor
  ]
)
class PageSelector {

  @Input()
  int activePage = 1;
  
  @Input()
  int pageCount = 0;

  @Input()
  int maxButtonCount = 5;

  int firstVisiblePage = 1;
  int get lastVisiblePage => firstVisiblePage + min(pageCount, maxButtonCount) - 1;

  List<int> get pages {
    int buttonsNumber = pageCount;
    if (pageCount > maxButtonCount) {
      buttonsNumber = maxButtonCount;
      if (activePage == firstVisiblePage) firstVisiblePage = max(firstVisiblePage - 1, 1);
      if (activePage == lastVisiblePage) firstVisiblePage = min(firstVisiblePage + 1, pageCount);
    }
    return List.generate(buttonsNumber, (int index) => firstVisiblePage + index);
  }

  final _onPageSelectController = StreamController<int>.broadcast();
  
  @Output()
  Stream<int> get onPageSelected => _onPageSelectController.stream;

  pageButtonClick(int selectedPage) {
    activePage = selectedPage;
    _onPageSelectController.add(activePage);
  }

  next() {
    if (activePage < pageCount) {
      activePage = activePage + 1;
      _onPageSelectController.add(activePage);
    }
  }

  previous() {
    if (activePage > 1) {
      activePage = activePage - 1;
      _onPageSelectController.add(activePage);
    }
  }
}