import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:injector/injector.dart' as di;

class TopRatedMoviesPage extends StatefulWidget {
  const TopRatedMoviesPage({super.key});

  @override
  State<TopRatedMoviesPage> createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  final movieBloc = di.locator<MovieBloc>();

  @override
  void initState() {
    super.initState();
    movieBloc.add(LoadDataTopRatedMovieEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieBloc>(
      create: (_) => movieBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Top Rated Movies'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              if (state is LoadingMovieState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SuccessLoadDataTopRatedMovieState) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = state.topRatedMovies[index];
                    return MovieCard(movie);
                  },
                  itemCount: state.topRatedMovies.length,
                );
              } else if (state is FailureMovieState) {
                return Center(
                  key: const Key('error_message'),
                  child: Text(state.message),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
