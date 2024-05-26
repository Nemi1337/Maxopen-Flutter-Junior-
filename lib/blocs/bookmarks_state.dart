part of 'bookmarks_bloc.dart';

abstract class BookmarksState extends Equatable {
  const BookmarksState();

  @override
  List<Object> get props => [];
}

class BookmarksInitial extends BookmarksState {}

class BookmarksLoaded extends BookmarksState {
  final List<Movie> bookmarks;

  const BookmarksLoaded({required this.bookmarks});

  @override
  List<Object> get props => [bookmarks];
}
class BookmarksCleared extends BookmarksState {}