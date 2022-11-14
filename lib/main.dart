import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';
import 'package:injector/injector.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        colorScheme: kColorScheme,
        primaryColor: kRichBlack,
        scaffoldBackgroundColor: kRichBlack,
        textTheme: kTextTheme,
      ),
      home: HomeMoviePage(),
      navigatorObservers: [routeObserver],
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/home':
            return MaterialPageRoute(builder: (_) => HomeMoviePage());
          case popularMovieRoute:
            return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
          case topRatedMovieRoute:
            return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
          case nowPlayingMovieRoute:
            return CupertinoPageRoute(builder: (_) => NowPlayingMoviesPage());
          case movieDetailRoute:
            final id = settings.arguments as int;
            return MaterialPageRoute(
              builder: (_) => MovieDetailPage(id: id),
              settings: settings,
            );
          case searchMovieRoute:
            return CupertinoPageRoute(builder: (_) => SearchMoviePage());
          case watchlistMovieRoute:
            return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
          case aboutRoute:
            return MaterialPageRoute(builder: (_) => AboutPage());
          case homeTvRoute:
            return MaterialPageRoute(builder: (_) => HomeTvPage());
          case searchTvRoute:
            return CupertinoPageRoute(builder: (_) => SearchTvPage());
          case nowPlayingTvRoute:
            return CupertinoPageRoute(builder: (_) => NowPlayingTvPage());
          case popularTvRoute:
            return CupertinoPageRoute(builder: (_) => PopularTvPage());
          case topRatedTvRoute:
            return CupertinoPageRoute(builder: (_) => TopRatedTvPage());
          case tvDetailRoute:
            final id = settings.arguments as int;
            return CupertinoPageRoute(builder: (_) => TvDetailPage(id: id));
          case watchlistTvRoute:
            return MaterialPageRoute(builder: (_) => WatchlistTvPage());
          default:
            return MaterialPageRoute(
              builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              },
            );
        }
      },
    );
  }
}
