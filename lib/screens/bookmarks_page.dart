import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_search_app/blocs/bookmarks_bloc.dart';
import 'package:movie_search_app/models/movie.dart';
import 'MovieDetailsScreen.dart';

class BookmarksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  Navigator.pushReplacementNamed(context, '/');
                }
              },
              child: SvgPicture.asset(
                'assets/back.svg',
                width: 14.23,
                height: 20.0,
                color: Colors.yellow,
              ),
            ),
            SizedBox(width: 20),
            Text(
              'Bookmarks',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              '.',
              style: TextStyle(color: Colors.yellow, fontSize: 34, fontWeight: FontWeight.bold),
            ),
          ],
        ),
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
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailsScreen(movie: movie),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 10.0, bottom: 10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 16,
                      height: 300,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                fit: BoxFit.cover,
                                height: 300,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${movie.title}',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                                SizedBox(height: 6),
                                Row(
                                  children: [
                                    Text(
                                      '${movie.rating.toStringAsFixed(1)}',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                    SizedBox(width: 10),
                                    Row(
                                      children: List.generate(
                                        5,
                                            (index) => Icon(
                                          Icons.star,
                                          color: index < (movie.rating * 2).round() ? Colors.yellow : Colors.grey,
                                          size: 22,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                  ],
                                ),
                                Text(
                                  'Genre: ${movie.genres.join(', ')}',
                                  style: TextStyle(fontSize: 13, color: Colors.white),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 6),
                                Text(
                                  '${movie.overview}',
                                  style: TextStyle(fontSize: 13, color: Colors.grey),
                                  maxLines: 6,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No bookmarks', style: TextStyle(color: Colors.white)));
          }
        },
      ),
    );
  }
}
