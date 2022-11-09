import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv/presentation/provider/watchlist_tv_notifier.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';

class WatchlistTvPage extends StatefulWidget {
  const WatchlistTvPage({Key? key}) : super(key: key);

  @override
  State<WatchlistTvPage> createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<WatchlistTvNotifier>(context, listen: false).fetchWatchlistTv());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistTvNotifier>(context, listen: false).fetchWatchlistTv();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Consumer<WatchlistTvNotifier>(
          builder: (context, data, child) {
            final state = data.watchlistState;
            if (state == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state == RequestState.loaded) {
              return ListView.builder(
                itemCount: data.watchlistTv.length,
                itemBuilder: (context, index) {
                  final tv = data.watchlistTv[index];
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
