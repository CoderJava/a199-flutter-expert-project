import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/provider/tv_list_notifier.dart';

class HomeTvPage extends StatefulWidget {
  const HomeTvPage({Key? key}) : super(key: key);

  @override
  State<HomeTvPage> createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<TvListNotifier>(context, listen: false)
      ..fetchNowPlayingTv()
      ..fetchPopularTv()
      ..fetchTopRatedTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Consumer<TvListNotifier>(
                builder: (context, data, child) {
                  final state = data.nowPlayingState;
                  if (state == RequestState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state == RequestState.loaded) {
                    return TvList(listTv: data.nowPlayingtv);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () {
                  Navigator.pushNamed(context, popularTvRoute);
                },
              ),
              Consumer<TvListNotifier>(
                builder: (context, data, child) {
                  final state = data.popularTvState;
                  if (state == RequestState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state == RequestState.loaded) {
                    return TvList(listTv: data.popularTv);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () {
                  Navigator.pushNamed(context, topRatedTvRoute);
                },
              ),
              Consumer<TvListNotifier>(
                builder: (context, data, child) {
                  final state = data.topRatedTvState;
                  if (state == RequestState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state == RequestState.loaded) {
                    return TvList(listTv: data.topRatedTv);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
            ],
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
