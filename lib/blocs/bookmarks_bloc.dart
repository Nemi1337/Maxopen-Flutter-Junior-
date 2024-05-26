import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_search_app/models/movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'bookmarks_event.dart';
part 'bookmarks_state.dart';


class BookmarksBloc extends Bloc<BookmarksEvent, BookmarksState> {
  List<Movie> _bookmarks = [];

  BookmarksBloc() : super(BookmarksInitial()) {
    on<AddBookmark>((event, emit) {
      _bookmarks.add(event.movie);
      emit(BookmarksLoaded(bookmarks: List.from(_bookmarks)));
    });

    on<RemoveBookmark>((event, emit) {
      _bookmarks.remove(event.movie);
      emit(BookmarksLoaded(bookmarks: List.from(_bookmarks)));
    });
  }

  @override
  void onTransition(Transition<BookmarksEvent, BookmarksState> transition) {
    print(transition);
    super.onTransition(transition);
  }
}
