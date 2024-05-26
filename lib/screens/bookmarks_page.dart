import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
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
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/');
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
        if (state is BookmarksInitial || state is BookmarksCleared) {
          return Center(child: Text('No movies saved', style: TextStyle(color: Colors.white)));
        } else if (state is BookmarksLoaded) {
          final bookmarks = state.bookmarks;
          if (bookmarks.isEmpty) {
            return Center(child: Text('No movies saved', style: TextStyle(color: Colors.white)));
          }
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
                                    '${movie.rating.clamp(0, 5).toStringAsFixed(1)}',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                  Row(
                                    children: List.generate(
                                      5,
                                          (index) {
                                        if (index + 1 <= movie.rating.clamp(0, 5).toInt()) {
                                          // Якщо індекс плюс 1 не більше, ніж ціла частина рейтингу, зарисовуємо жовту зірочку
                                          return Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 22,
                                          );
                                        } else if (index < movie.rating.clamp(0, 5).toInt()) {
                                          // Якщо індекс менше цілої частини рейтингу, зарисовуємо наполовину жовту зірочку
                                          return Icon(
                                            Icons.star_half,
                                            color: Colors.yellow,
                                            size: 22,
                                          );
                                        } else {
                                          // В іншому випадку зарисовуємо сіру зірочку
                                          return Icon(
                                            Icons.star,
                                            color: Colors.grey,
                                            size: 22,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                ],
                              ),
                              Text(
                                ' ${movie.genres.map((genre) => genre.toString()).join(', ')}',
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