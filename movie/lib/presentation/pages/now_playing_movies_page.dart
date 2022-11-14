import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:injector/injector.dart' as di;

class NowPlayingMoviesPage extends StatefulWidget {
  const NowPlayingMoviesPage({Key? key}) : super(key: key);

  @override
  State<NowPlayingMoviesPage> createState() => _NowPlayingMoviesPageState();
}

class _NowPlayingMoviesPageState extends State<NowPlayingMoviesPage> {
  final movieBloc = di.locator<MovieBloc>();

  @override
  void initState() {
    super.initState();
    movieBloc.add(LoadDataNowPlayingMovieEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieBloc>(
      create: (_) => movieBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Now Playing Movies'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              if (state is LoadingMovieState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SuccessLoadDataNowPlayingMovieState) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = state.nowPlayingMovies[index];
                    return MovieCard(movie);
                  },
                  itemCount: state.nowPlayingMovies.length,
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
