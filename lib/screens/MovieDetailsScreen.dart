import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../blocs/bookmarks_bloc.dart';
import '../models/movie.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  MovieDetailsScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(
                'assets/back.svg',
                width: 24.0,
                height: 24.0,
                color: Colors.yellow,
              ),
            ),
            Spacer(),
            BlocBuilder<BookmarksBloc, BookmarksState>(
              builder: (context, state) {
                bool isBookmarked = false;
                if (state is BookmarksLoaded) {
                  isBookmarked = state.bookmarks.contains(movie);
                }
                return GestureDetector(
                  onTap: () {
                    if (isBookmarked) {
                      BlocProvider.of<BookmarksBloc>(context).add(RemoveBookmark(movie));
                    } else {
                      BlocProvider.of<BookmarksBloc>(context).add(AddBookmark(movie));
                    }
                  },
                  child: SvgPicture.asset(
                    'assets/3.svg',
                    width: 24.0,
                    height: 24.0,
                    color: isBookmarked ? Colors.yellow : Colors.white,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.5),
                        Colors.black.withOpacity(0.7),
                        Colors.black,
                      ],
                      stops: [0.6, 0.75, 0.85, 1.0],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
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
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              color: Colors.black.withOpacity(0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${movie.genres.map((genre) => genre.toString()).join(', ')}',
                    style: TextStyle(fontSize: 13, color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Text(
                    movie.overview,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF888888),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
