  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:flutter_svg/flutter_svg.dart';
  import 'package:carousel_slider/carousel_slider.dart';
  import 'package:movie_search_app/screens/see_more_page.dart';
  import '../blocs/bookmarks_bloc.dart';
  import '../blocs/movie_bloc.dart';
  import 'MovieDetailsScreen.dart';

  class HomePage extends StatelessWidget {
  const HomePage({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Row(
            children: [
              Text(
                'Top Five',
                style: TextStyle(color: Colors.white,  fontSize: 28,fontWeight: FontWeight.bold),
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
              return const Center(child: CircularProgressIndicator());
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
                                        width: double.infinity,
                                        height: 220,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                      child: Text(
                                        movie.title,
                                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                                      child:  Row(
                                        children: [
                                          Text(
                                            movie.rating.clamp(0, 5).toStringAsFixed(1),
                                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                          ),
                                          Row(
                                            children: List.generate(
                                              5,
                                                  (index) {
                                                if (index + 1 <= movie.rating.clamp(0, 5).toInt()) {
                                                  // Якщо індекс плюс 1 не більше, ніж ціла частина рейтингу, зарисовуємо жовту зірочку
                                                  return const Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                    size: 22,
                                                  );
                                                } else if (index < movie.rating.clamp(0, 5).toInt()) {
                                                  // Якщо індекс менше цілої частини рейтингу, зарисовуємо наполовину жовту зірочку
                                                  return const Icon(
                                                    Icons.star_half,
                                                    color: Colors.yellow,
                                                    size: 22,
                                                  );
                                                } else {
                                                  // В іншому випадку зарисовуємо сіру зірочку
                                                  return const Icon(
                                                    Icons.star,
                                                    color: Colors.grey,
                                                    size: 22,
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 10),
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
                                          'assets/3.svg',
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
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
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SeeMorePage(movies: state.movies.skip(5).toList()),
                                ),
                              );
                            },
                            child: const Text(
                              'SEE MORE',
                              style: TextStyle(color: Colors.yellow, fontSize: 13.5),
                            ),
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
                                  const SizedBox(width: 8),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          movie.title,
                                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                        ),
                                        const SizedBox(height: 6),
                                        Row(
                                          children: [
                                            Text(
                                              movie.rating.clamp(0, 5).toStringAsFixed(1),
                                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                            ),
                                            Row(
                                              children: List.generate(
                                                5,
                                                    (index) {
                                                  if (index + 1 <= movie.rating.clamp(0, 5).toInt()) {
                                                    // Якщо індекс плюс 1 не більше, ніж ціла частина рейтингу, зарисовуємо жовту зірочку
                                                    return const Icon(
                                                      Icons.star,
                                                      color: Colors.yellow,
                                                      size: 22,
                                                    );
                                                  } else if (index < movie.rating.clamp(0, 5).toInt()) {
                                                    // Якщо індекс менше цілої частини рейтингу, зарисовуємо наполовину жовту зірочку
                                                    return const Icon(
                                                      Icons.star_half,
                                                      color: Colors.yellow,
                                                      size: 22,
                                                    );
                                                  } else {
                                                    // В іншому випадку зарисовуємо сіру зірочку
                                                    return const Icon(
                                                      Icons.star,
                                                      color: Colors.grey,
                                                      size: 22,
                                                    );
                                                  }
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                          ],
                                        ),
                                        Text(
                                          'Genre: ${movie.genres.isNotEmpty ? movie.genres.join(', ') : 'Unknown'}',
                                          style: const TextStyle(fontSize: 13, color: Colors.white),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),




                                        const SizedBox(height: 6),
                                        Text(
                                          movie.overview,
                                          style: const TextStyle(fontSize: 13, color: Colors.grey),
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
                      }).toList(),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('Failed to load movies'));
            }
          },
        ),
      );
    }
  }
