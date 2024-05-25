import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_search_app/models/movie.dart';

class MovieApiService {
  static const String _apiKey = '45ff267e29545205c31d29b3f1f78e29';
  static const String _accessToken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0NWZmMjY3ZTI5NTQ1MjA1YzMxZDI5YjNmMWY3OGUyOSIsInN1YiI6IjY2NTFjMzliODExY2YxN2MxMTk2MTE5YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.OuC692CDTAlbXUYHRXtbIMMAz95c5qw_9eBEiAqQIEA';
  static const String _baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Movie>> fetchTopMovies() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/top_rated?api_key=$_apiKey'),
      headers: {
        'Authorization': 'Bearer $_accessToken',
        'Content-Type': 'application/json;charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List movies = data['results'];
      return movies.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load top movies');
    }
  }
}
