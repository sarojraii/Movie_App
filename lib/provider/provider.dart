import 'package:flutter/foundation.dart';

import '../model/models.dart';

class MovieProvider with ChangeNotifier {
  List<Result> movie = [];

  void addItem(Result films) {
    if (!movie.contains(films)) {
      movie.add(films);
      notifyListeners();
    }
  }

  void removeItem(Result film) {
    movie.remove(film);
    notifyListeners();
  }
}
