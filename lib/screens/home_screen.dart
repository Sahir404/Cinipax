import 'package:cinepax_flutter/dummy_data/dummy_data.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import '../constants/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/movie_item.dart';
import 'package:provider/provider.dart';
import '../providers/movies.dart';
import '../widgets/movie_item_widget.dart';
import '../widgets/upcoming_movie.dart';
import '../utils.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = 'home-screen/';
  List<MovieItem> _movies = [];
  List<MovieItem> _upcomingMovies = [];

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final moviesProvider = Provider.of<Movies>(context, listen: false);
    _movies = moviesProvider.getAllMovies;
    _upcomingMovies = moviesProvider.getUpcomingMovies;
    return Scaffold(
      body: SafeArea(
        // top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(0),
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Consumer<Movies>(
                  builder: (context, movies, child) {
                    return Stack(
                      children: [
                        Image.asset(
                          _movies[movies.getCenterItemIndex].imagePath,
                          height: size.height * 0.68,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                        BlurryContainer(
                          width: double.infinity,
                          height: size.height * 0.68,
                          blur: 10,
                          color: Colors.transparent,
                          borderRadius: const BorderRadius.all(Radius.zero),
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(top: size.height * 0.099),
                                child: CarouselSlider.builder(
                                  itemBuilder: (context, index, realIndex) {
                                    return MovieItemWidget(
                                      currentItemIndex: index,
                                      centerItemIndex:
                                          movies.getCenterItemIndex,
                                    );
                                  },
                                  itemCount: _movies.length,
                                  options: CarouselOptions(
                                    autoPlay: false,
                                    scrollDirection: Axis.horizontal,
                                    enlargeCenterPage: true,
                                    // enlargeStrategy: CenterPageEnlargeStrategy.height,
                                    initialPage: 1,
                                    enableInfiniteScroll: false,
                                    // height: 800,
                                    aspectRatio: 8 / 6,
                                    viewportFraction: 0.55,
                                    onPageChanged: (index, reason) {
                                      Provider.of<Movies>(context,
                                              listen: false)
                                          .setCenterItemIndex(index);
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
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
                              const SizedBox(height: 8),
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
                              width: size.width / 2 + 4,
                              height: 40,
                              decoration: const BoxDecoration(
                                // border: Border.all(color: Colors.green, width: 2),
                                border: Border(
                                  top: BorderSide(
                                      color: Colors.transparent, width: 2),
                                ),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -18,
                          right: 0,
                          child: RotationTransition(
                            turns: AlwaysStoppedAnimation(8 / 360),
                            child: Container(
                              width: size.width / 2 + 4,
                              height: 40,
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                      color: Colors.transparent, width: 2),
                                ),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Image.asset(
                  'assets/images/cinepax_logo.png',
                  width: 120,
                  height: 50,
                  alignment: Alignment.center,
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Upcoming movies',
                  style: kHeadlineMedium,
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: size.height * 0.76,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _upcomingMovies.length,
                      itemBuilder: (context, index) {
                        return UpcomingMovie(index: index);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
