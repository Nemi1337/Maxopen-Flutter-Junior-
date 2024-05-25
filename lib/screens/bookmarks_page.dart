import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search_app/blocs/bookmarks_bloc.dart';

class BookmarksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bookmarks')),
      body: BlocBuilder<BookmarksBloc, BookmarksState>(
        builder: (context, state) {
          if (state is BookmarksLoaded) {
            return ListView.builder(
              itemCount: state.bookmarks.length,
              itemBuilder: (context, index) {
                final movie = state.bookmarks[index];
                return ListTile(
                  title: Text(movie.title),
                  subtitle: Text(movie.overview),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      BlocProvider.of<BookmarksBloc>(context).add(AddBookmark(movie));
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
