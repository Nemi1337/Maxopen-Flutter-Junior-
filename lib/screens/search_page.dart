import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_search_app/blocs/bookmarks_bloc.dart';
import 'package:movie_search_app/models/movie.dart';
import '../services/movie_api_service.dart';
import 'MovieDetailsScreen.dart';
import 'package:http/http.dart' as http;


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Movie> _searchResults = [];

  void _performSearch(String query) {
    print('Search query: $query');
    if (query.isNotEmpty) {
      MovieApiService().fetchMovies(query).then((movies) {
        setState(() {
          _searchResults = movies;
        });
        print('Search results length: ${_searchResults.length}');
      }).catchError((error) {
        print('Failed to load movies: $error');
        setState(() {
          _searchResults = [];
        });
      });
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }



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
              'Search',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              '.',
              style: TextStyle(color: Colors.yellow, fontSize: 34, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              //width: 379,
              height: 70,
              decoration: BoxDecoration(
                color: Color(0xFF2B2B2B),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SvgPicture.asset(
                      'assets/2.svg',
                      width: 20.01,
                      height: 20,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (query) => _performSearch(query),
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Search results (${_searchResults.length})',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: _searchResults.isEmpty
                ? Center(
              child: Text(
                'No results',
                style: TextStyle(color: Colors.white),
              ),
            )
                : ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                print('Building item $index');
                final movie = _searchResults[index];
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
            ),
          ),
        ],
      ),
    );
  }
}
