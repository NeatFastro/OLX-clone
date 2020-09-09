import 'package:flutter/cupertino.dart';

class ExploreState extends ChangeNotifier {
  String searchTerms = 'search cars, mobile phone, and more';

  changeSearcTerm(String query) {
    print('changing search term to $query');
    if (query.isNotEmpty) {
      searchTerms = query;
      print('notifying listener about change in search term');
      notifyListeners();
    }
  }
}
