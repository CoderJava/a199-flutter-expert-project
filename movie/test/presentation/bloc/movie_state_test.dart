import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/bloc/movie_bloc.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  group('InitialMovieState', () {
    final tState = InitialMovieState();

    test(
      'make sure output toString function',
      () async {
        // act
        final result = tState.toString();

        // assert
        expect(result, 'InitialMovieState{}');
      },
    );
  });

  group('LoadingMovieState', () {
    final tState = LoadingMovieState();

    test(
      'make sure output toString function',
      () async {
        // act
        final result = tState.toString();

        // assert
        expect(result, 'LoadingMovieState{}');
      },
    );
  });

  group('FailureMovieState', () {
    final tState = FailureMovieState(message: 'message');

    test(
      'make sure output toString function',
      () async {
        // act
        final result = tState.toString();

        // assert
        expect(result, 'FailureMovieState{message: ${tState.message}}');
      },
    );
  });

  group('SuccessLoadDataHomeMovieState', () {
    final tState = SuccessLoadDataHomeMovieState(
      nowPlayingMovies: testMovieList,
      popularMovies: testMovieList,
      topRatedMovies: testMovieList,
    );

    test(
      'make sure output toString function',
      () async {
        // act
        final result = tState.toString();

        // assert
        expect(
          result,
          'SuccessLoadDataHomeMovieState{nowPlayingMovies: ${tState.nowPlayingMovies}, popularMovies: ${tState.popularMovies}, '
          'topRatedMovies: ${tState.topRatedMovies}}',
        );
      },
    );
  });

  group('SuccessLoadDataNowPlayingMovieState', () {
    final tState = SuccessLoadDataNowPlayingMovieState(nowPlayingMovies: testMovieList);

    test(
      'make sure output toString function',
      () async {
        // act
        final result = tState.toString();

        // assert
        expect(
          result,
          'SuccessLoadDataNowPlayingMovieState{nowPlayingMovies: ${tState.nowPlayingMovies}}',
        );
      },
    );
  });

  group('SuccessLoadDataPopularMovieState', () {
    final tState = SuccessLoadDataPopularMovieState(popularMovies: testMovieList);

    test(
      'make sure output toString function',
      () async {
        // act
        final result = tState.toString();

        // assert
        expect(
          result,
          'SuccessLoadDataPopularMovieState{popularMovies: ${tState.popularMovies}}',
        );
      },
    );
  });

  group('SuccessLoadDataTopRatedMovieState', () {
    final tState = SuccessLoadDataTopRatedMovieState(topRatedMovies: testMovieList);

    test(
      'make sure output toString function',
      () async {
        // act
        final result = tState.toString();

        // assert
        expect(result, 'SuccessLoadDataTopRatedMovieState{topRatedMovies: ${tState.topRatedMovies}}');
      },
    );
  });

  group('SuccessLoadDataDetailMovieState', () {
    final tState = SuccessLoadDataDetailMovieState(
      movieDetail: testMovieDetail,
      movieRecommendations: testMovieList,
      isAddedToWatchlist: true,
    );

    test(
      'make sure output toString function',
      () async {
        // act
        final result = tState.toString();

        // assert
        expect(
          result,
          'SuccessLoadDataDetailMovieState{movieDetail: ${tState.movieDetail}, '
          'movieRecommendations: ${tState.movieRecommendations}, isAddedToWatchlist: ${tState.isAddedToWatchlist}}',
        );
      },
    );
  });

  group('SuccessSearchMovieState', () {
    final tState = SuccessSearchMovieState(searchResult: testMovieList);

    test(
      'make sure output toString function',
      () async {
        // act
        final result = tState.toString();

        // assert
        expect(result, 'SuccessSearchMovieState{searchResult: ${tState.searchResult}}');
      },
    );
  });

  group('SuccessLoadDataWatchlistMovieState', () {
    final tState = SuccessLoadDataWatchlistMovieState(watchlistMovies: testMovieList);

    test(
      'make sure output toString function',
      () async {
        // act
        final result = tState.toString();

        // assert
        expect(result, 'SuccessLoadDataWatchlistMovieState{watchlistMovies: ${tState.watchlistMovies}}');
      },
    );
  });

  group('SuccessUpdateWatchlistStatusMovieState', () {
    final tState = SuccessUpdateWatchlistStatusMovieState(message: 'message', isAddedToWatchlist: true);

    test(
      'make sure output toString function',
      () async {
        // act
        final result = tState.toString();

        // assert
        expect(result,
            'SuccessUpdateWatchlistStatusMovieState{message: ${tState.message}, isAddedToWatchlist: ${tState.isAddedToWatchlist}}');
      },
    );
  });
}
