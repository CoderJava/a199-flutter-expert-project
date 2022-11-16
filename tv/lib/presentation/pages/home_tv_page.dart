import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart' as di;
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/bloc/tv_bloc.dart';

class HomeTvPage extends StatefulWidget {
  const HomeTvPage({Key? key}) : super(key: key);

  @override
  State<HomeTvPage> createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  final tvBloc = di.locator<TvBloc>();

  @override
  void initState() {
    super.initState();
    tvBloc.add(LoadDataHomeTvEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TvBloc>(
      create: (_) => tvBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TV'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, searchTvRoute);
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSubHeading(
                  title: 'Now Playing',
                  onTap: () {
                    Navigator.pushNamed(context, nowPlayingTvRoute);
                  },
                ),
                BlocBuilder<TvBloc, TvState>(
                  builder: (context, state) {
                    if (state is LoadingTvState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is SuccessLoadDataHomeTvState) {
                      return TvList(listTv: state.nowPlayingTv);
                    } else if (state is FailureTvState) {
                      return const Text('Failed');
                    }
                    return Container();
                  },
                ),
                _buildSubHeading(
                  title: 'Popular',
                  onTap: () {
                    Navigator.pushNamed(context, popularTvRoute);
                  },
                ),
                BlocBuilder<TvBloc, TvState>(
                  builder: (context, state) {
                    if (state is LoadingTvState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is SuccessLoadDataHomeTvState) {
                      return TvList(listTv: state.popularTv);
                    } else if (state is FailureTvState) {
                      return const Text('Failed');
                    }
                    return Container();
                  },
                ),
                _buildSubHeading(
                  title: 'Top Rated',
                  onTap: () {
                    Navigator.pushNamed(context, topRatedTvRoute);
                  },
                ),
                BlocBuilder<TvBloc, TvState>(
                  builder: (context, state) {
                    if (state is LoadingTvState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is SuccessLoadDataHomeTvState) {
                      return TvList(listTv: state.topRatedTv);
                    } else if (state is FailureTvState) {
                      return const Text('Failed');
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                Text('See More'),
                Icon(
                  Icons.arrow_forward_ios,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> listTv;

  const TvList({
    Key? key,
    required this.listTv,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = listTv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                FirebaseAnalytics.instance.logEvent(
                  name: 'select_tv',
                  parameters: {
                    'content-type': 'tv',
                    'title': tv.name ?? '-',
                  },
                );
                Navigator.pushNamed(
                  context,
                  tvDetailRoute,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
                child: (tv.posterPath ?? '').isEmpty
                    ? const Icon(Icons.error)
                    : CachedNetworkImage(
                        imageUrl: '$baseImageUrl${tv.posterPath}',
                        placeholder: (context, url) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
              ),
            ),
          );
        },
        itemCount: listTv.length,
      ),
    );
  }
}
