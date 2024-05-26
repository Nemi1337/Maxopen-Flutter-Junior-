import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_search_app/blocs/bookmarks_bloc.dart';
import 'package:movie_search_app/models/movie.dart';
import 'MovieDetailsScreen.dart';

class SeeMorePage extends StatelessWidget {
  final List<Movie> movies;

  SeeMorePage({required this.movies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
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
              'Latest',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              '.',
              style: TextStyle(color: Colors.yellow, fontSize: 34, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 0.7),
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailsScreen(movie: movie),
                ),
              );
            },
            child: Card(
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${movie.title}',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              '${movie.rating.toStringAsFixed(1)}',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(width: 5),
                            Row(
                              children: List.generate(
                                5,
                                    (index) => Icon(
                                  Icons.star,
                                  color: index < (movie.rating * 2).round() ? Colors.yellow : Colors.grey,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
