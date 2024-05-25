
part of 'bookmarks_bloc.dart';


abstract class BookmarksEvent extends Equatable {
  const BookmarksEvent();

  @override
  List<Object> get props => [];
}

class AddBookmark extends BookmarksEvent {
  final Movie movie;

  AddBookmark(this.movie);

  @override
  List<Object> get props => [movie];
}

class RemoveBookmark extends BookmarksEvent {
  final Movie movie;

  RemoveBookmark(this.movie);

  @override
  List<Object> get props => [movie];
}
