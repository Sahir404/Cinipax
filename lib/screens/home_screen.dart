import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants.dart';
import '../models/movie_item.dart';
import '../providers/movies.dart';
import '../utils.dart';
import '../widgets/movie_item_widget.dart';
import '../widgets/upcoming_movie.dart';

class HomeScreen extends StatelessWidget {
  List<MovieItem> _movies = [];
  List<MovieItem> _upcomingMovies = [];

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('home build called');
    final moviesProvider = Provider.of<Movies>(context, listen: false);
    _movies = moviesProvider.getAllMovies;
    _upcomingMovies = moviesProvider.getUpcomingMovies;
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Image.asset(
            'assets/images/upcoming_movies/upcoming_movies_background.png',
            fit: BoxFit.fitWidth,
          ),
        ),
        Container(
          color: Colors.transparent,
          height: 100.h < 700 ? 130.h : 120.h,
          child: Stack(
            children: [
              Consumer<Movies>(
                builder: (context, movies, child) {
                  return Stack(
                    children: [
                      Image.asset(
                        _movies[movies.getCenterItemIndex].imagePath,
                        height: 100.h < 700 ? 81.h : 79.h,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                      BlurryContainer(
                        width: double.infinity,
                        height: 100.h < 700 ? 81.h : 79.h,
                        blur: 10,
                        color: Colors.transparent,
                        borderRadius: const BorderRadius.all(Radius.zero),
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 16.h),
                              child: CarouselSlider.builder(
                                itemBuilder: (context, index, realIndex) {
                                  return MovieItemWidget(
                                    currentItemIndex: index,
                                    centerItemIndex: movies.getCenterItemIndex,
                                  );
                                },
                                itemCount: _movies.length,
                                options: CarouselOptions(
                                  autoPlay: false,
                                  scrollPhysics:
                                      const AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  enlargeCenterPage: true,
                                  // enlargeStrategy: CenterPageEnlargeStrategy.height,
                                  initialPage: movies.getCenterItemIndex,
                                  enableInfiniteScroll: false,
                                  height: 40.h,
                                  // aspectRatio: 8.8 / 7.7,
                                  viewportFraction: 0.54,
                                  onPageChanged: (index, reason) {
                                    Provider.of<Movies>(context, listen: false)
                                        .setCenterItemIndex(index);
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),
                            Hero(
                              tag:
                                  'title-tag-${_movies[movies.getCenterItemIndex].id}',
                              child: Material(
                                type: MaterialType.transparency,
                                child: Text(
                                  _movies[movies.getCenterItemIndex].title,
                                  style: kHeadlineLarge,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Hero(
                              tag:
                                  'ratings-tag-${_movies[movies.getCenterItemIndex].id}',
                              child: Material(
                                type: MaterialType.transparency,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Ratings : ',
                                        style: kHeadlineSmall),
                                    ...Utils.getRatings(
                                      _movies[movies.getCenterItemIndex]
                                          .ratingInStars,
                                      Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Hero(
                              tag:
                                  'genre-tag-${_movies[movies.getCenterItemIndex].id}',
                              child: Material(
                                type: MaterialType.transparency,
                                child: Text(
                                  'Genre : ${_movies[movies.getCenterItemIndex].genre}',
                                  style: kHeadlineSmall,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: -18,
                        left: 0,
                        child: RotationTransition(
                          turns: const AlwaysStoppedAnimation(-8 / 360),
                          child: Container(
                            width: 100.w / 2 + 4,
                            height: 40,
                            decoration: const BoxDecoration(
                              // border: Border.all(color: Colors.green, width: 2),
                              border: Border(
                                top: BorderSide(
                                    color: Colors.transparent, width: 2),
                              ),
                              color: Colors.transparent,
                            ),
                            child: Image.asset(
                              'assets/images/upcoming_movies/upcoming_movies_background.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -18,
                        right: 0,
                        child: RotationTransition(
                          turns: const AlwaysStoppedAnimation(8 / 360),
                          child: Container(
                            width: 100.w / 2 + 4,
                            height: 40,
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                    color: Colors.transparent, width: 2),
                              ),
                              color: Colors.transparent,
                            ),
                            child: Image.asset(
                              'assets/images/upcoming_movies/upcoming_movies_background.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Positioned(
                bottom: 100.h < 800 ? -4 : 14,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/cinepax_logo.png',
                      width: 140,
                      height: 80,
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Upcoming movies',
                      style: kHeadlineMedium,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 100.w,
                      height: 210,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: _upcomingMovies.length,
                        itemBuilder: (context, index) {
                          return UpcomingMovie(index: index);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
