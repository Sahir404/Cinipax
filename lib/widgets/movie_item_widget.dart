// ignore_for_file: use_key_in_widget_constructors

import 'package:cinepax_flutter/models/movie_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movies.dart';
import '../widgets/movie_item_widget.dart';

class MovieItemWidget extends StatelessWidget {
  late List<MovieItem> movies;
  int centerItemIndex;
  int currentItemIndex;

  MovieItemWidget(
      {required this.currentItemIndex, required this.centerItemIndex});

  @override
  Widget build(BuildContext context) {
    movies = Provider.of<Movies>(context, listen: false).getAllMovies;
    return Container(
      decoration: BoxDecoration(
        border: currentItemIndex == centerItemIndex
            ? Border.all(color: Colors.white)
            : null,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          movies[currentItemIndex].imagePath,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
