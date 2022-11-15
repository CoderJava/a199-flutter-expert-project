import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/bloc/movie_bloc.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  group('LoadDataHomeMovieEvent', () {
    final tEvent = LoadDataHomeMovieEvent();

    test(
      'make sure output toString function',
      () async {
        // act
        final result = tEvent.toString();

        // assert
        expect(result, 'LoadDataHomeMovieEvent{}');
      },
    );
  });

  group('LoadDataNowPlayingMovieEvent', () {
    final tEvent = LoadDataNowPlayingMovieEvent();

    test(
      'make sure output toString function',
      () async {
        // act
        final result = tEvent.toString();

        // assert
        expect(result, 'LoadDataNowPlayingMovieEvent{}');
      },
    );
  });

  group('LoadDataPopularMovieEvent', () {
    final tEvent = LoadDataPopularMovieEvent();

    test(
      'make sure output toString function',
      () async {
        // act
        final result = tEvent.toString();

        // assert
        expect(result, 'LoadDataPopularMovieEvent{}');
      },
    );
  });

  group('LoadDataTopRatedMovieEvent', () {
    final tEvent = LoadDataTopRatedMovieEvent();

    test(
      'make sure output toString function',
      () async {
        // act
        final result = tEvent.toString();

        // assert
        expect(result, 'LoadDataTopRatedMovieEvent{}');
      },
    );
  });

  group('LoadDataDetailMovieEvent', () {
    final tEvent = LoadDataDetailMovieEvent(id: 1);

    test(
      'make sure output toString function',
      () async {
        // act
        final result = tEvent.toString();

        // assert
        expect(result, 'LoadDataDetailMovieEvent{id: ${tEvent.id}}');
      },
    );
  });

  group('SearchMovieEvent', () {
    final tEvent = SearchMovieEvent(query: 'query');

    test(
      'make sure output toString function',
      () async {
        // act
        final result = tEvent.toString();

        // assert
        expect(result, 'SearchMovieEvent{query: ${tEvent.query}}');
      },
    );
  });

  group('LoadDataWatchlistMovieEvent', () {
    final tEvent = LoadDataWatchlistMovieEvent();

    test(
      'make sure output toString function',
      () async {
        // act
        final result = tEvent.toString();

        // assert
        expect(result, 'LoadDataWatchlistMovieEvent{}');
      },
    );
  });

  group('AddWatchlistMovieEvent', () {
    final tEvent = AddWatchlistMovieEvent(movie: testMovieDetail);

    test(
      'make sure output toString function',
      () async {
        // act
        final result = tEvent.toString();

        // assert
        expect(result, 'AddWatchlistMovieEvent{movie: ${tEvent.movie}}');
      },
    );
  });

  group('RemoveWatchlistMovieEvent', () {
    final tEvent = RemoveWatchlistMovieEvent(movie: testMovieDetail);

    test(
      'make sure output toString function',
      () async {
        // act
        final result = tEvent.toString();

        // assert
        expect(result, 'RemoveWatchlistMovieEvent{movie: ${tEvent.movie}}');
      },
    );
  });
}
