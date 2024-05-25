import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/movie.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  MovieDetailsScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.network(
                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height / 2,
                  width: double.infinity,
                ),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black.withOpacity(0), Colors.black.withOpacity(0.7)],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        movie.title,
                        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            '${movie.rating.toStringAsFixed(1)}',
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
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
                    ],
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.black.withOpacity(0.5), // Фоновий колір під текстом
              padding: EdgeInsets.all(8.0),
              child: Text(
                movie.overview,
                style: TextStyle(fontSize: 16, color: Color(0xFF888888)), // Колір тексту
              ),
            ),
          ],
        ),
      ),
    );
  }
}
