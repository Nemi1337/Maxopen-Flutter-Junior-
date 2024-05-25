import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'blocs/movie_bloc.dart';
import 'screens/home_page.dart';
import 'screens/search_page.dart';
import 'screens/bookmarks_page.dart';
import 'screens/movie_details_page.dart';
import 'services/movie_api_service.dart';
import 'bottom_nav_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movieApiService = MovieApiService();
    final GoRouter _router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => HomePageWrapper(),
        ),
        GoRoute(
          path: '/search',
          builder: (context, state) => SearchPageWrapper(),
        ),
        GoRoute(
          path: '/bookmarks',
          builder: (context, state) => BookmarksPageWrapper(),
        ),
        GoRoute(
          path: '/movie/:id',
          builder: (context, state) => MovieDetailsPage(movieId: state.params['id']!),
        ),
      ],
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MovieBloc(movieApiService)..add(FetchTopMovies()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}

class HomePageWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          // Your builder logic here
          return HomePage(); // Placeholder widget, replace with your actual widget
        },
      ),
      bottomNavigationBar: BottomNavBar(selectedIndex: 0),
    );
  }
}

class SearchPageWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SearchPage(),
      bottomNavigationBar: BottomNavBar(selectedIndex: 1),
    );
  }
}

class BookmarksPageWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BookmarksPage(),
      bottomNavigationBar: BottomNavBar(selectedIndex: 2),
    );
  }
}
