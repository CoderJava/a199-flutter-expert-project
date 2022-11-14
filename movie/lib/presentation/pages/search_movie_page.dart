import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart' as di;
import 'package:movie/presentation/bloc/movie_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';

class SearchMoviePage extends StatefulWidget {
  const SearchMoviePage({super.key});

  @override
  State<SearchMoviePage> createState() => _SearchMoviePageState();
}

class _SearchMoviePageState extends State<SearchMoviePage> {
  final movieBloc = di.locator<MovieBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieBloc>(
      create: (_) => movieBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search Movie'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onSubmitted: (query) {
                  movieBloc.add(SearchMovieEvent(query: query));
                },
                decoration: const InputDecoration(
                  hintText: 'Search title',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.search,
              ),
              const SizedBox(height: 16),
              Text(
                'Search Result',
                style: kHeading6,
              ),
              BlocBuilder<MovieBloc, MovieState>(
                builder: (context, state) {
                  if (state is LoadingMovieState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is SuccessSearchMovieState) {
                    final result = state.searchResult;
                    return result.isEmpty
                        ? const Expanded(
                            child: Center(
                              child: Text(
                                'Data not found',
                                key: Key('data_not_found'),
                              ),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.all(8),
                              itemBuilder: (context, index) {
                                final movie = state.searchResult[index];
                                return MovieCard(movie);
                              },
                              itemCount: result.length,
                            ),
                          );
                  } else {
                    return Expanded(
                      child: Container(
                        key: const Key(
                          'empty_container',
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
