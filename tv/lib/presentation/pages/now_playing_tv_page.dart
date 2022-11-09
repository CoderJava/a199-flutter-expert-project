import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv/presentation/provider/now_playing_tv_notifier.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';

class NowPlayingTvPage extends StatefulWidget {
  const NowPlayingTvPage({Key? key}) : super(key: key);

  @override
  State<NowPlayingTvPage> createState() => _NowPlayingTvPageState();
}

class _NowPlayingTvPageState extends State<NowPlayingTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<NowPlayingTvNotifier>(context, listen: false).fetchNowPlayingTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Consumer<NowPlayingTvNotifier>(
          builder: (context, data, chid) {
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
