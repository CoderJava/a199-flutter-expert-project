import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv/presentation/provider/popular_tv_notifier.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';

class PopularTvPage extends StatefulWidget {
  const PopularTvPage({Key? key}) : super(key: key);

  @override
  State<PopularTvPage> createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<PopularTvNotifier>(context, listen: false).fetchPopularTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Consumer<PopularTvNotifier>(
          builder: (context, data, child) {
            final state = data.state;
            if (state == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state == RequestState.loaded) {
              return ListView.builder(
                itemCount: data.tv.length,
                itemBuilder: (context, index) {
                  final tv = data.tv[index];
                  return TvCard(tv: tv);
                },
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
