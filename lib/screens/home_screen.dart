import 'package:cinepax_flutter/dummy_data/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import '../constants/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/movie_item.dart';
import 'package:provider/provider.dart';
import '../providers/movies.dart';
import '../widgets/movie_item_widget.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = 'home-screen/';
  List<MovieItem> _movies = [];

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _movies = Provider.of<Movies>(context, listen: false).getAllMovies;
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
                          height: size.height * 0.66,
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                        ),
                        BlurryContainer(
                          width: double.infinity,
                          height: size.height * 0.66,
                          blur: 10,
                          color: Colors.transparent,
                          borderRadius: const BorderRadius.all(Radius.zero),
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(top: size.height * 0.08),
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
                              Text(
                                _movies[movies.getCenterItemIndex].title,
                                style: kHeadlineLarge,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Ratings : ',
                                      style: kHeadlineSmall),
                                  for (int i = 0,
                                          j = _movies[movies.getCenterItemIndex]
                                              .ratingInStars;
                                      i < 5;
                                      i++, j--)
                                    Icon(
                                      j > 0 ? Icons.star : Icons.star_border,
                                      color:
                                          j > 0 ? Colors.yellow : Colors.white,
                                      size: 20,
                                    ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Genre : ${_movies[movies.getCenterItemIndex].genre}',
                                style: kHeadlineSmall,
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
                              height: 45,
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
                              height: 45,
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
                  width: 130,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 6),
                const Text(
                  'Upcoming movies',
                  style: kHeadlineMedium,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        height: 120,
                        decoration: const BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        height: 120,
                        decoration: const BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        height: 120,
                        decoration: const BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
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
