// ignore_for_file: use_key_in_widget_constructors
import 'package:cinepax_flutter/models/movie_item.dart';
import 'package:cinepax_flutter/screens/movie_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movies.dart';

class MovieItemWidget extends StatelessWidget {
  late List<MovieItem> movies;
  int centerItemIndex;
  int currentItemIndex;

  MovieItemWidget(
      {required this.currentItemIndex, required this.centerItemIndex});

  @override
  Widget build(BuildContext context) {
    movies = Provider.of<Movies>(context, listen: false).getAllMovies;
    return GestureDetector(
      onTap: () {
        currentItemIndex == centerItemIndex
            ? Navigator.of(context).pushNamed(MovieDetailsScreen.routeName)
            : null;
      },
      child: Container(
        // height: 200,
        decoration: BoxDecoration(
          border: currentItemIndex == centerItemIndex
              ? Border.all(color: Colors.white)
              : null,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Hero(
            tag: 'current-movie-image-tag${movies[currentItemIndex].id}',
            transitionOnUserGestures: true,
            child: Material(
              type: MaterialType.transparency,
              color: Colors.transparent,
              child: Image.asset(
                movies[currentItemIndex].imagePath,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
