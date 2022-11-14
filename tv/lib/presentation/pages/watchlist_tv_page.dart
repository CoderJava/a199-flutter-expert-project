import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart' as di;
import 'package:tv/presentation/bloc/tv_bloc.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';

class WatchlistTvPage extends StatefulWidget {
  const WatchlistTvPage({Key? key}) : super(key: key);

  @override
  State<WatchlistTvPage> createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> with RouteAware {
  final tvBloc = di.locator<TvBloc>();

  @override
  void initState() {
    super.initState();
    doLoadData();
  }

  void doLoadData() {
    tvBloc.add(LoadDataWatchlistTvEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    doLoadData();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TvBloc>(
      create: (_) => tvBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Watchlist TV'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocBuilder<TvBloc, TvState>(
            builder: (context, state) {
              if (state is LoadingTvState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SuccessLoadDataWatchlistTvState) {
                return ListView.builder(
                  itemCount: state.watchlistTv.length,
                  itemBuilder: (context, index) {
                    final tv = state.watchlistTv[index];
                    return TvCard(tv: tv);
                  },
                );
              } else if (state is FailureTvState) {
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
