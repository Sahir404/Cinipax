import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cinepax_flutter/constants/constants.dart';
import 'package:cinepax_flutter/models/movie_item.dart';
import 'package:cinepax_flutter/providers/movies.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpcomingMovie extends StatelessWidget {
  List<MovieItem> _upcomingMovies = [];
  final index;

  UpcomingMovie({required this.index});

  @override
  Widget build(BuildContext context) {
    _upcomingMovies = Provider.of<Movies>(context).getUpcomingMovies;
    return Container(
      width: double.infinity,
      height: 120,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.infinity,
            height: 120,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(14),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(14),
              ),
              child: Image.asset(
                _upcomingMovies[index].imagePath,
                fit: BoxFit.fill,
              ),
            ),
          ),
          BlurryContainer(
            width: double.infinity,
            height: 30,
            blur: 3,
            color: kUpcomingMovieTitleBackgroundColor,
            // color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(14),
              bottomRight: Radius.circular(14),
            ),
            child: Text(
              _upcomingMovies[index].title,
              textAlign: TextAlign.center,
              style: kHeadlineSmall.copyWith(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
