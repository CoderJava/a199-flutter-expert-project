import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv/presentation/provider/top_rated_tv_notifier.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';

class TopRatedTvPage extends StatefulWidget {
  const TopRatedTvPage({Key? key}) : super(key: key);

  @override
  State<TopRatedTvPage> createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<TopRatedTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<TopRatedTvNotifier>(context, listen: false).fetchTopRatedTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Consumer<TopRatedTvNotifier>(
          builder: (context, data, child) {
            final state = data.state;
            if (state == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state == RequestState.loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.tv[index];
                  return TvCard(tv: tv);
                },
                itemCount: data.tv.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
