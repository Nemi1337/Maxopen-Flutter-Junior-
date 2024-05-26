import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../blocs/bookmarks_bloc.dart';
import '../blocs/movie_bloc.dart';
import 'MovieDetailsScreen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Text(
              'Top Five',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              '.',
              style: TextStyle(color: Colors.yellow, fontSize: 34, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MovieLoaded) {
            final topFiveMovies = state.movies.take(5).toList();
            final latestMovies = state.movies.skip(5).take(6).toList();
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider.builder(
                    itemCount: topFiveMovies.length,
                    itemBuilder: (context, index, realIndex) {
                      final movie = topFiveMovies[index];
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
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Image.network(
                                      'https://image.tmdb.org/t/p/w1000${movie.posterPath}',
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width - 150,
                                      height: 230,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                    child: Text(
                                      movie.title,
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          '${movie.rating.toStringAsFixed(1)}',
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                        ),
                                        SizedBox(width: 5),
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
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 16.0,
                                right: 14.0,
                                child: BlocBuilder<BookmarksBloc, BookmarksState>(
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
                                        'assets/3.svg', // Замість 'your_icon.svg' вкажіть шлях до вашого SVG
                                        color: isBookmarked ? Colors.yellow : Colors.white,
                                        width: 24.0,
                                        height: 24.0,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 300,
                      viewportFraction: 0.7,
                      autoPlay: true,
                      enlargeCenterPage: false,
                      aspectRatio: 2.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Text(
                          'Latest',
                          style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '.',
                          style: TextStyle(color: Colors.yellow, fontSize: 34, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: latestMovies.map((movie) {
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
                            height: 273,
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
                                      height: 273,
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
                                            '${movie.rating.toStringAsFixed(1)}', // Display rating as decimal
                                            style: TextStyle(fontSize: 16, color: Colors.white),
                                          ),
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
                                        'Genre: ${movie.genres.join(', ')}\n${movie.overview}',
                                        style: TextStyle(fontSize: 13, color: Colors.white),
                                        maxLines: 8,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
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
                                            'assets/3.svg', // Замість 'your_icon.svg' вкажіть шлях до вашого SVG
                                            color: isBookmarked ? Colors.yellow : Colors.white,
                                            width: 24.0,
                                            height: 24.0,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('Failed to load movies'));
          }
        },
      ),
    );
  }
}
