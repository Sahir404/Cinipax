import 'package:cinepax_flutter/dummy_data/dummy_data.dart';
import 'package:cinepax_flutter/models/movie_item.dart';
import 'package:flutter/material.dart';

class Movies with ChangeNotifier {
  final List<MovieItem> _movies = SAMPLE_MOVIES;
  final List<MovieItem> _upcomingMovies = UPCOMING_MOVIES;
  int _index = 1;

  List<MovieItem> get getAllMovies {
    return [..._movies];
  }

  List<MovieItem> get getUpcomingMovies {
    return [..._upcomingMovies];
  }

  void setCenterItemIndex(int index) {
    _index = index;
    notifyListeners();
  }

  int get getCenterItemIndex {
    return _index;
  }

  MovieItem get getCenterItem {
    return _movies[_index];
  }
}
