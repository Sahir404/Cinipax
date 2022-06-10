import 'package:cinepax_flutter/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/movie_item.dart';
import '../providers/movies.dart';
import '../utils.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailsScreen extends StatefulWidget {
  static const routeName = 'movie-details-screen/';

  MovieDetailsScreen({Key? key}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen>
    with SingleTickerProviderStateMixin {
  late MovieItem _currentMovie;
  late AnimationController _controller;
  late YoutubePlayerController _youtubePlayerController;
  var _isInitialized = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Future.delayed(Duration.zero);
    _currentMovie = Provider.of<Movies>(context, listen: false).getCenterItem;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _controller.forward(from: 0.5);
    _controller.addListener(() {
      setState(() {});
    });
    try {
      _youtubePlayerController = YoutubePlayerController(
          initialVideoId:
              YoutubePlayer.convertUrlToId(_currentMovie.trailerUrl)!,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            controlsVisibleAtStart: true,
            showLiveFullscreenButton: false,
            isLive: false,
          ));
      // ..addListener(() {
      //   if (mounted) {
      //     setState(() {});
      //   }
      // });
    } catch (exception) {
      print(exception.toString());
      _isInitialized = false;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _youtubePlayerController.dispose();
    super.dispose();
  }

  @override
  void deactivete() {
    _youtubePlayerController.pause();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print('build called');
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              // bottom: 0,
              left: 0,
              right: 0,
              child: HeroMode(
                enabled: _controller.value >= 1.0 ? true : false,
                child: Hero(
                  tag: 'current-movie-image-tag${_currentMovie.id}',
                  transitionOnUserGestures: true,
                  child: Material(
                    type: MaterialType.transparency,
                    color: Colors.transparent,
                    child: Image.asset(
                      _currentMovie.imagePath,
                      height: size.height * 0.7,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // top: size.height * 0.3,
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _controller.value * size.height * 0.67,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 26),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _currentMovie.title,
                      style: kHeadlineMedium.copyWith(
                        fontSize: 22,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          'Ratings : ',
                          style: kHeadlineSmall.copyWith(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ...Utils.getRatings(
                          _currentMovie.ratingInStars,
                          Colors.black,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Genre : ${_currentMovie.genre}',
                      style: kHeadlineSmall.copyWith(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Director : ',
                              style: kHeadlineSmall.copyWith(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _currentMovie.director,
                              style: kHeadlineSmall.copyWith(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time_outlined,
                              color: kPrimaryColor,
                              size: 22,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _currentMovie.length,
                              style: kHeadlineSmall.copyWith(
                                fontSize: 13,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      _currentMovie.description,
                      softWrap: true,
                      style: kHeadlineSmall.copyWith(
                        color: kPrimaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Trailer',
                      style: kHeadlineMedium.copyWith(
                        fontSize: 22,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (_isInitialized)
                      YoutubePlayerBuilder(
                        player: YoutubePlayer(
                          controller: _youtubePlayerController,
                          showVideoProgressIndicator: true,
                          bottomActions: [],
                        ),
                        onEnterFullScreen: null,
                        builder: (context, player) {
                          return Column(
                            children: [
                              SizedBox(
                                  width: double.infinity,
                                  // height: 260,
                                  child: player),
                            ],
                          );
                        },
                      ),
                    SizedBox(height: 200),
                    // SizedBox(height: 200),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
