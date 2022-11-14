import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:injector/injector.dart' as di;
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/presentation/bloc/movie_bloc.dart';

class MovieDetailPage extends StatefulWidget {
  final int id;

  const MovieDetailPage({super.key, required this.id});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final movieBloc = di.locator<MovieBloc>();
  final movieRecommendations = <Movie>[];
  MovieDetail? movie;
  var isAddedToWatchlist = false;

  @override
  void initState() {
    super.initState();
    movieBloc.add(LoadDataDetailMovieEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieBloc>(
      create: (_) => movieBloc,
      child: Scaffold(
        body: BlocListener<MovieBloc, MovieState>(
          listener: (context, state) {
            if (state is SuccessUpdateWatchlistStatusMovieState) {
              final message = state.message;
              if (message == MovieBloc.watchlistAddSuccessMessage ||
                  message == MovieBloc.watchlistRemoveSuccessMessage) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                isAddedToWatchlist = !isAddedToWatchlist;
                setState(() {});
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(message),
                    );
                  },
                );
              }
            } else if (state is SuccessLoadDataDetailMovieState) {
              movie = state.movieDetail;
              movieRecommendations.clear();
              movieRecommendations.addAll(state.movieRecommendations);
              isAddedToWatchlist = state.isAddedToWatchlist;
            }
          },
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              if (state is LoadingMovieState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SuccessLoadDataDetailMovieState || state is SuccessUpdateWatchlistStatusMovieState) {
                return SafeArea(
                  child: DetailContentMovie(
                    movie!,
                    movieRecommendations,
                    isAddedToWatchlist,
                  ),
                );
              } else if (state is FailureMovieState) {
                return Center(
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

class DetailContentMovie extends StatefulWidget {
  final MovieDetail movie;
  final List<Movie> recommendations;
  final bool isAddedWatchlist;

  const DetailContentMovie(
    this.movie,
    this.recommendations,
    this.isAddedWatchlist, {
    super.key,
  });

  @override
  State<DetailContentMovie> createState() => _DetailContentMovieState();
}

class _DetailContentMovieState extends State<DetailContentMovie> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        (widget.movie.posterPath ?? '').isEmpty
            ? const Icon(Icons.error)
            : CachedNetworkImage(
                imageUrl: 'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}',
                width: screenWidth,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
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
                              widget.movie.title,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!widget.isAddedWatchlist) {
                                  BlocProvider.of<MovieBloc>(context).add(AddWatchlistMovieEvent(movie: widget.movie));
                                } else {
                                  BlocProvider.of<MovieBloc>(context)
                                      .add(RemoveWatchlistMovieEvent(movie: widget.movie));
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
                              _showGenres(widget.movie.genres),
                            ),
                            Text(
                              _showDuration(widget.movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.movie.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.movie.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<MovieBloc, MovieState>(
                              builder: (context, state) {
                                if (state is LoadingMovieState) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is FailureMovieState) {
                                  return Text(state.message);
                                } else if (state is SuccessLoadDataDetailMovieState ||
                                    state is SuccessUpdateWatchlistStatusMovieState) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie = widget.recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                movieDetailRoute,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
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
}
