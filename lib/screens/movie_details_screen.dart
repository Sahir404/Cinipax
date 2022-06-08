import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/movie_item.dart';
import '../providers/movies.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const routeName = 'movie-details-screen/';
  late MovieItem _currentMovie;

  MovieDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _currentMovie = Provider.of<Movies>(context).getCenterItem;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Hero(
                tag: 'current-movie-tag',
                child: Image.asset(
                  _currentMovie.imagePath,
                  height: size.height * 0.7,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
