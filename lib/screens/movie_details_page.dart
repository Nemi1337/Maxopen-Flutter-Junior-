import 'package:flutter/material.dart';

class MovieDetailsPage extends StatelessWidget {
  final String movieId;

  MovieDetailsPage({required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Movie Details')),
      body: Center(child: Text('Details for movie ID: $movieId')),
    );
  }
}
