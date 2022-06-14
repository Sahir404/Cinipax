import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cinepax_flutter/constants/constants.dart';
import 'package:cinepax_flutter/models/movie_item.dart';
import 'package:cinepax_flutter/providers/movies.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpcomingMovie extends StatelessWidget {
  List<MovieItem> _upcomingMovies = [];
  final index;
  final size;

  UpcomingMovie({required this.index, required this.size});

  @override
  Widget build(BuildContext context) {
    _upcomingMovies = Provider.of<Movies>(context).getUpcomingMovies;
    return Container(
      width: 240,
      height: 130,
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
                'assets/images/upcoming_movies/sample_upcoming_movie1.png'),
          ),
          Text(
            _upcomingMovies[index].title,
          ),
        ],
      ),
    );
  }
}
