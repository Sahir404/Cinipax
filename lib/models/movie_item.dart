class MovieItem {
  String id;
  String title;
  String description;
  String imagePath;
  int ratingInStars;
  String genre;
  String director;
  String length;
  String trailerUrl;
  String releaseDate;

  MovieItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.ratingInStars,
    required this.genre,
    required this.director,
    required this.length,
    required this.trailerUrl,
    this.releaseDate = '',
  });
}
