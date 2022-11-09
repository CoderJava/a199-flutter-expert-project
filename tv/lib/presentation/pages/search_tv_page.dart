import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv/presentation/provider/tv_search_notifier.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';

class SearchTvPage extends StatefulWidget {
  const SearchTvPage({Key? key}) : super(key: key);

  @override
  State<SearchTvPage> createState() => _SearchTvPageState();
}

class _SearchTvPageState extends State<SearchTvPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TvSearchNotifier>(context, listen: false).resetTvSearch();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Provider.of<TvSearchNotifier>(context, listen: false).fetchTvSearch(query);
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
            Consumer<TvSearchNotifier>(
              builder: (context, data, child) {
                final state = data.state;
                if (state == RequestState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.loaded) {
                  final result = data.searchResult;
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
                              final tv = data.searchResult[index];
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
    );
  }
}
