import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart' as di;
import 'package:tv/presentation/bloc/tv_bloc.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';

class SearchTvPage extends StatefulWidget {
  const SearchTvPage({Key? key}) : super(key: key);

  @override
  State<SearchTvPage> createState() => _SearchTvPageState();
}

class _SearchTvPageState extends State<SearchTvPage> {
  final tvBloc = di.locator<TvBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TvBloc>(
      create: (_) => tvBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search TV'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onSubmitted: (query) {
                  tvBloc.add(SearchTvEvent(query: query));
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
              BlocBuilder<TvBloc, TvState>(
                builder: (context, state) {
                  if (state is LoadingTvState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is SuccessSearchTvState) {
                    final result = state.searchResult;
                    return result.isEmpty
                        ? const Expanded(
                            child: Center(
                              child: Text(
                                'Data not found',
                                key: Key(
                                  'data_not_found',
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                final tv = state.searchResult[index];
                                return TvCard(tv: tv);
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
