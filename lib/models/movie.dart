class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final double rating;
  final List<String> genres;
  bool isSaved;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.rating,
    required this.genres,
    this.isSaved = false,
  });

  // Фабричний конструктор з JSON
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No Title',
      overview: json['overview'] ?? 'No Overview',
      posterPath: json['poster_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['poster_path']}'
          : 'https://example.com/default.jpg',
      releaseDate: json['release_date'] ?? 'Unknown',
      rating: (json['vote_average'] ?? 0.0).toDouble(),
      genres: json['genres'] != null
          ? List<String>.from(json['genres'])
          : ['Unknown'],
    );
  }
}
