import 'package:flutter/foundation.dart';
// import 'package:provider/provider.dart';

class AppState extends ChangeNotifier {
  String _search = '';

  String get searchText => _search;

  void setSearchText(text) {
    _search = text;
    notifyListeners();
  }
}
