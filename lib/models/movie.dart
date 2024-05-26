import 'dart:convert';
import 'package:http/http.dart' as http;

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
          ? List<String>.from(json['genres'].map((genre) => genre['name']))
          : ['Unknown'],
    );
  }

  static Future<List<Movie>> fetchMovies(String query) async {
    final response = await http.get(Uri.parse('https://example.com/api/movies?query=$query'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
