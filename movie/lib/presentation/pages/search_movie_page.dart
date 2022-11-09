import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movie/presentation/provider/movie_search_notifier.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:provider/provider.dart';

class SearchMoviePage extends StatefulWidget {
  const SearchMoviePage({super.key});

  @override
  State<SearchMoviePage> createState() => _SearchMoviePageState();
}

class _SearchMoviePageState extends State<SearchMoviePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieSearchNotifier>(context, listen: false).resetMovieSearch();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Provider.of<MovieSearchNotifier>(context, listen: false).fetchMovieSearch(query);
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
            Consumer<MovieSearchNotifier>(
              builder: (context, data, child) {
                if (data.state == RequestState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data.state == RequestState.loaded) {
                  final result = data.searchResult;
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
                              final movie = data.searchResult[index];
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
    );
  }
}
