import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/presentation/provider/tv_detail_notifier.dart';

class TvDetailPage extends StatefulWidget {
  final int id;

  const TvDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<TvDetailPage> createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TvDetailNotifier>(context, listen: false).fetchTvDetail(widget.id);
      Provider.of<TvDetailNotifier>(context, listen: false).loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvDetailNotifier>(
        builder: (context, data, child) {
          final state = data.tvState;
          if (state == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state == RequestState.loaded) {
            final tv = data.tv;
            return SafeArea(
              child: DetailContentTv(
                tv: tv,
                recommendations: data.tvRecommendations,
                isAddedWatchlist: data.isAddedToWatchlist,
              ),
            );
          } else {
            return Center(
              child: Text(data.message),
            );
          }
        },
      ),
    );
  }
}

class DetailContentTv extends StatefulWidget {
  final TvDetail tv;
  final List<Tv> recommendations;
  final bool isAddedWatchlist;

  const DetailContentTv({
    Key? key,
    required this.tv,
    required this.recommendations,
    required this.isAddedWatchlist,
  }) : super(key: key);

  @override
  State<DetailContentTv> createState() => _DetailContentTvState();
}

class _DetailContentTvState extends State<DetailContentTv> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        (widget.tv.posterPath ?? '').isEmpty
            ? const Icon(Icons.error)
            : CachedNetworkImage(
                imageUrl: 'https://image.tmdb.org/t/p/w500${widget.tv.posterPath}',
                width: screenWidth,
                placeholder: (context, url) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tv.name ?? '-',
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!widget.isAddedWatchlist) {
                                  await Provider.of<TvDetailNotifier>(context, listen: false).addWatchlist(widget.tv);
                                } else {
                                  await Provider.of<TvDetailNotifier>(context, listen: false).removeFromWatchlist(widget.tv);
                                }

                                if (!mounted) {
                                  return;
                                }

                                final message = Provider.of<TvDetailNotifier>(context, listen: false).watchlistMessage;

                                if (message == TvDetailNotifier.watchlistAddSuccessMessage ||
                                    message == TvDetailNotifier.watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  widget.isAddedWatchlist ? const Icon(Icons.check) : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(widget.tv.genres ?? []),
                            ),
                            Text(
                              _showDuration(widget.tv.lastEpisodeToAir?.runtime ?? 0),
                            ),
                            Text(
                              _showEpisode(widget.tv.numberOfEpisodes ?? -1),
                            ),
                            Text(
                              _showSeason(widget.tv.numberOfSeasons ?? -1),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: (widget.tv.voteAverage ?? 0) / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.tv.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.tv.overview ?? '-',
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            Consumer<TvDetailNotifier>(
                              builder: (context, data, child) {
                                if (data.recommendationState == RequestState.loading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (data.recommendationState == RequestState.error) {
                                  return Text(data.message);
                                } else if (data.recommendationState == RequestState.loaded) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tv = widget.recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                tvDetailRoute,
                                                arguments: tv.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: (tv.posterPath ?? '').isEmpty
                                                  ? const Icon(Icons.error)
                                                  : CachedNetworkImage(
                                                      imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                                      placeholder: (context, url) => const Center(
                                                        child: CircularProgressIndicator(),
                                                      ),
                                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                                    ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: widget.recommendations.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  String _showEpisode(int episode) {
    final text = episode == -1 ? '-' : '$episode';
    return 'Episode: $text';
  }

  String _showSeason(int season) {
    final text = season == -1 ? '-' : '$season';
    return 'Season: $text';
  }
}
