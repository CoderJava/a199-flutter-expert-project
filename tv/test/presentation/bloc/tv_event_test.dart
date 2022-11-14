import 'package:flutter_test/flutter_test.dart';
import 'package:tv/presentation/bloc/tv_bloc.dart';

void main() {
  group('LoadDataHomeTvEvent', () {
    final tEvent = LoadDataHomeTvEvent();

    test(
      'make sure output toString function',
          () async {
        // act
        final result = tEvent.toString();

        // assert
        expect(result, 'LoadDataHomeTvEvent{}');
      },
    );
  });

  group('LoadDataNowPlayingTvEvent', () {
    final tEvent = LoadDataNowPlayingTvEvent();

    test(
      'make sure output toString function',
          () async {
        // act
        final result = tEvent.toString();

        // assert
        expect(result, 'LoadDataNowPlayingTvEvent{}');
      },
    );
  });

  group('LoadDataPopularTvEvent', () {
    final tEvent = LoadDataPopularTvEvent();

    test(
      'make sure output toString function',
          () async {
        // act
        final result = tEvent.toString();

        // assert
        expect(result, 'LoadDataPopularTvEvent{}');
      },
    );
  });

  group('LoadDataTopRatedTvEvent', () {
    final tEvent = LoadDataTopRatedTvEvent();

    test(
      'make sure output toString function',
          () async {
        // act
        final result = tEvent.toString();

        // assert
        expect(result, 'LoadDataTopRatedTvEvent{}');
      },
    );
  });

  group('LoadDataDetailTvEvent', () {
    final tEvent = LoadDataDetailTvEvent(id: 1);

    test(
      'make sure output toString function',
          () async {
        // act
        final result = tEvent.toString();

        // assert
        expect(result, 'LoadDataDetailTvEvent{id: ${tEvent.id}}');
      },
    );
  });

  group('SearchTvEvent', () {
    final tEvent = SearchTvEvent(query: 'query');

    test(
      'make sure output toString function',
          () async {
        // act
        final result = tEvent.toString();

        // assert
        expect(result, 'SearchTvEvent{query: ${tEvent.query}}');
      },
    );
  });
}