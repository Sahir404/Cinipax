import 'package:cinepax_flutter/constants/constants.dart';
import 'package:cinepax_flutter/screens/show_booking_screen.dart';
import 'package:cinepax_flutter/screens/show_desc_screen.dart';
import 'package:cinepax_flutter/widgets/show_dual_buttons.dart';
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
  ScrollController _scrollController = ScrollController();
  var _isInitialized = true;
  var _showBookingPage = false;

  @override
  void initState() {
    super.initState();
    _initAnimController();
    _initYoutubeController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _youtubePlayerController.dispose();
    _scrollController.dispose();
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
                      width: double.infinity,
                      fit: BoxFit.fitHeight,
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
                height: _showBookingPage
                    ? _controller.value * size.height * 0.67 +
                        size.height * 0.18
                    : _controller.value * size.height * 0.67,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  controller: _scrollController,
                  children: [
                    // if (!_showBookingPage)
                    AnimatedOpacity(
                      opacity: _showBookingPage ? 0 : 1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                      child: SizedBox(
                        height: _showBookingPage ? 0 : null,
                        child: ShowDescScreen(
                          currentMovie: _currentMovie,
                          isInitialized: _isInitialized,
                          youtubePlayerController: _youtubePlayerController,
                        ),
                      ),
                    ),
                    ShowDualButtons(
                      size: size,
                      topBtnText: 'Description',
                      bottomBtnText: 'Booking',
                      showTopButton: _showBookingPage,
                      showBottomPageCallBack: () {
                        setState(() {
                          _showBookingPage = true;
                          _scrollController.animateTo(
                            _scrollController.position.minScrollExtent,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeIn,
                          );
                        });
                      },
                      showTopPageCallBack: () {
                        setState(() {
                          _showBookingPage = false;
                        });
                      },
                      topBtnPadding: 0,
                      bottomBtnPadding: 0,
                      marginRight: 75,
                      marginLeft: 75,
                      marginTop: 20,
                    ),
                    if (_showBookingPage)
                      ShowBookingScreen(
                        size: size,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _initAnimController() {
    _currentMovie = Provider.of<Movies>(context, listen: false).getCenterItem;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _controller.forward(from: 0.5);
    _controller.addListener(() {
      setState(() {});
    });
  }

  void _initYoutubeController() {
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
}
