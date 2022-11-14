import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart' as di;
import 'package:tv/presentation/bloc/tv_bloc.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';

class PopularTvPage extends StatefulWidget {
  const PopularTvPage({Key? key}) : super(key: key);

  @override
  State<PopularTvPage> createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvPage> {
  final tvBloc = di.locator<TvBloc>();

  @override
  void initState() {
    super.initState();
    tvBloc.add(LoadDataPopularTvEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TvBloc>(
      create: (_) => tvBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Popular TV'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocBuilder<TvBloc, TvState>(
            builder: (context, state) {
              if (state is LoadingTvState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SuccessLoadDataPopularTvState) {
                return ListView.builder(
                  itemCount: state.popularTv.length,
                  itemBuilder: (context, index) {
                    final tv = state.popularTv[index];
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
