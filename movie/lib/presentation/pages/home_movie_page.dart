import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart' as di;
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/bloc/movie_bloc.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({super.key});

  @override
  State<HomeMoviePage> createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  final movieBloc = di.locator<MovieBloc>();

  @override
  void initState() {
    super.initState();
    movieBloc.add(LoadDataHomeMovieEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieBloc>(
      create: (_) => movieBloc,
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              const UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/circle-g.png'),
                ),
                accountName: Text('Ditonton'),
                accountEmail: Text('ditonton@dicoding.com'),
              ),
              ListTile(
                leading: const Icon(Icons.movie),
                title: const Text('Movies'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.tv),
                title: const Text('TV'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, homeTvRoute);
                },
              ),
              ListTile(
                leading: const Icon(Icons.save_alt),
                title: const Text('Watchlist Movies'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, watchlistMovieRoute);
                },
              ),
              ListTile(
                leading: const Icon(Icons.save_alt),
                title: const Text('Watchlist TV'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, watchlistTvRoute);
                },
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, aboutRoute);
                },
                leading: const Icon(Icons.info_outline),
                title: const Text('About'),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('Movies'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, searchMovieRoute);
              },
              icon: const Icon(Icons.search),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSubHeading(
                  title: 'Now Playing',
                  onTap: () => Navigator.pushNamed(context, nowPlayingMovieRoute),
                ),
                BlocBuilder<MovieBloc, MovieState>(
                  builder: (context, state) {
                    if (state is LoadingMovieState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is SuccessLoadDataHomeMovieState) {
                      return MovieList(state.nowPlayingMovies);
                    } else if (state is FailureMovieState) {
                      return const Text('Failed');
                    }
                    return Container();
                  },
                ),
                _buildSubHeading(
                  title: 'Popular',
                  onTap: () => Navigator.pushNamed(context, popularMovieRoute),
                ),
                BlocBuilder<MovieBloc, MovieState>(
                  builder: (context, state) {
                    if (state is LoadingMovieState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is SuccessLoadDataHomeMovieState) {
                      return MovieList(state.popularMovies);
                    } else if (state is FailureMovieState) {
                      return const Text('Failed');
                    }
                    return Container();
                  },
                ),
                _buildSubHeading(
                  title: 'Top Rated',
                  onTap: () => Navigator.pushNamed(context, topRatedMovieRoute),
                ),
                BlocBuilder<MovieBloc, MovieState>(
                  builder: (context, state) {
                    if (state is LoadingMovieState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is SuccessLoadDataHomeMovieState) {
                      return MovieList(state.topRatedMovies);
                    } else if (state is FailureMovieState) {
                      return const Text('Failed');
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                Text('See More'),
                Icon(
                  Icons.arrow_forward_ios,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                FirebaseAnalytics.instance.logEvent(
                  name: 'select_movie',
                  parameters: {
                    'content-type': 'movie',
                    'title': movie.title ?? '-',
                  },
                );
                Navigator.pushNamed(
                  context,
                  movieDetailRoute,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: (movie.posterPath ?? '').isEmpty
                    ? const Icon(Icons.error)
                    : CachedNetworkImage(
                        imageUrl: '$baseImageUrl${movie.posterPath}',
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
