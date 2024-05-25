import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_search_app/models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  MovieCard(this.movie);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 300,
              height: 200,
              child: Stack(
                children: [
                  Image.network(
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    width: 300,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      icon: SvgPicture.asset(
                        'assets/3.svg',
                        width: 24,
                        height: 24,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // Handle save button press
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 300,
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Text(
                  '${movie.title}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 6),
            Row(
              children: List.generate(
                5, // Display 5 stars
                    (index) => Icon(
                  Icons.star,
                  color: index < (movie.rating / 2).round() ? Colors.yellow : Colors.grey,
                  size: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
