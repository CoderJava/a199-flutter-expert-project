import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart' as di;
import 'package:tv/presentation/bloc/tv_bloc.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';

class TopRatedTvPage extends StatefulWidget {
  const TopRatedTvPage({Key? key}) : super(key: key);

  @override
  State<TopRatedTvPage> createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<TopRatedTvPage> {
  final tvBloc = di.locator<TvBloc>();

  @override
  void initState() {
    super.initState();
    tvBloc.add(LoadDataTopRatedTvEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TvBloc>(
      create: (_) => tvBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Top Rated TV'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocBuilder<TvBloc, TvState>(
            builder: (context, state) {
              if (state is LoadingTvState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SuccessLoadDataTopRatedTvState) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tv = state.topRatedTv[index];
                    return TvCard(tv: tv);
                  },
                  itemCount: state.topRatedTv.length,
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
