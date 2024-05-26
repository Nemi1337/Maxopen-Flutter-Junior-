import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search_app/blocs/bookmarks_bloc.dart';
import 'package:movie_search_app/models/movie.dart';

class BookmarksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks'),
      ),
      body: BlocBuilder<BookmarksBloc, BookmarksState>(
        builder: (context, state) {
          if (state is BookmarksInitial) {
            return Center(child: CircularProgressIndicator());
          } else if (state is BookmarksLoaded) {
            final bookmarks = state.bookmarks;
            return ListView.builder(
              itemCount: bookmarks.length,
              itemBuilder: (context, index) {
                final movie = bookmarks[index];
                return ListTile(
                  title: Text(movie.title),
                  subtitle: Text(movie.overview),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      BlocProvider.of<BookmarksBloc>(context).add(RemoveBookmark(movie));
                    },
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No bookmarks'));
          }
        },
      ),
    );
  }
}
