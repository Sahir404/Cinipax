import 'package:flutter/material.dart';

class Utils {
  static List<Widget> getRatings(int ratingsInStars, Color unratedStarColor) {
    List<Widget> ratings = [];
    for (int i = 0, j = ratingsInStars; i < 5; i++, j--) {
      ratings.add(Icon(
        j > 0 ? Icons.star : Icons.star_border,
        color: j > 0 ? Colors.yellow : unratedStarColor,
        size: 20,
      ));
    }
    return ratings;
  }
}
