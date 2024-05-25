import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search_app/models/movie.dart';
import 'package:movie_search_app/services/movie_api_service.dart';

// Define the events
abstract class MovieEvent {}

class FetchTopMovies extends MovieEvent {}

// Define the states
abstract class MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movie> movies;
  MovieLoaded(this.movies);
}

class MovieError extends MovieState {
  final String message;
  MovieError(this.message);
}

// Define the BLoC
class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieApiService movieApiService;

  MovieBloc(this.movieApiService) : super(MovieLoading()) {
    on<FetchTopMovies>((event, emit) async {
      try {
        final movies = await movieApiService.fetchTopMovies();
        emit(MovieLoaded(movies));
      } catch (e) {
        emit(MovieError(e.toString()));
      }
    });
  }
  }
