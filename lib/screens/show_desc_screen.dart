import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../constants/constants.dart';
import '../models/movie_item.dart';
import '../utils.dart';

class ShowDescScreen extends StatelessWidget {
  const ShowDescScreen({
    Key? key,
    required MovieItem currentMovie,
    required bool isInitialized,
    required YoutubePlayerController youtubePlayerController,
  })  : _currentMovie = currentMovie,
        _isInitialized = isInitialized,
        _youtubePlayerController = youtubePlayerController,
        super(key: key);

  final MovieItem _currentMovie;
  final bool _isInitialized;
  final YoutubePlayerController _youtubePlayerController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: 'title-tag-${_currentMovie.id}',
            child: Material(
              type: MaterialType.transparency,
              child: Text(
                _currentMovie.title,
                style: kHeadlineMedium.copyWith(
                  fontSize: 22,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Hero(
            tag: 'ratings-tag-${_currentMovie.id}',
            child: Material(
              type: MaterialType.transparency,
              child: Row(
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
            ),
          ),
          const SizedBox(height: 12),
          Hero(
            tag: 'genre-tag-${_currentMovie.id}',
            child: Material(
              type: MaterialType.transparency,
              child: Text(
                'Genre : ${_currentMovie.genre}',
                style: kHeadlineSmall.copyWith(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
                return player;
              },
            ),
        ],
      ),
    );
  }
}
