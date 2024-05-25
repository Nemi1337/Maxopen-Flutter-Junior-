import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_search_app/models/movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'bookmarks_event.dart';
part 'bookmarks_state.dart';

class BookmarksBloc extends Bloc<BookmarksEvent, BookmarksState> {
  BookmarksBloc() : super(BookmarksInitial());

  List<Movie> _bookmarks = [];

  @override
  Stream<BookmarksState> mapEventToState(
      BookmarksEvent event,
      ) async* {
    if (event is AddBookmark) {
      _bookmarks.add(event.movie);
      yield BookmarksLoaded(bookmarks: List.from(_bookmarks));
    } else if (event is RemoveBookmark) {
      _bookmarks.remove(event.movie);
      yield BookmarksLoaded(bookmarks: List.from(_bookmarks));
    }
  }



  @override
  void onTransition(Transition<BookmarksEvent, BookmarksState> transition) {
    print(transition);
    super.onTransition(transition);
  }
}
