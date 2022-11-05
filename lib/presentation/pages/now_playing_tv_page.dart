import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/now_playing_tv_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NowPlayingTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-tv';

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
        title: Text('Now Playing TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Consumer<NowPlayingTvNotifier>(
          builder: (context, data, chid) {
            final state = data.state;
            if (state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state == RequestState.Loaded) {
              return ListView.builder(
                itemCount: data.tv.length,
                itemBuilder: (context, index) {
                  final tv = data.tv[index];
                  return TvCard(tv: tv);
                },
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
