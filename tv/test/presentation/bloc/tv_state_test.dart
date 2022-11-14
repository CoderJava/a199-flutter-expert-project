import 'package:flutter_test/flutter_test.dart';
import 'package:tv/presentation/bloc/tv_bloc.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  group('InitialTvState', () {
    final tState = InitialTvState();

    test(
      'make sure output toString function',
          () async {
        // act
        final result = tState.toString();

        // assert
        expect(result, 'InitialTvState{}');
      },
    );
  });

  group('LoadingTvState', () {
    final tState = LoadingTvState();

    test(
      'make sure output toString function',
          () async {
        // act
        final result = tState.toString();

        // assert
        expect(result, 'LoadingTvState{}');
      },
    );
  });

  group('FailureTvState', () {
    final tState = FailureTvState(message: 'message');

    test(
      'make sure output toString function',
          () async {
        // act
        final result = tState.toString();

        // assert
        expect(result, 'FailureTvState{message: ${tState.message}}');
      },
    );
  });

  group('SuccessLoadDataHomeTvState', () {
    final tState = SuccessLoadDataHomeTvState(
      nowPlayingTv: testTvList,
      popularTv: testTvList,
      topRatedTv: testTvList,
    );

    test(
      'make sure output toString function',
          () async {
        // act
        final result = tState.toString();

        // assert
        expect(
          result,
          'SuccessLoadDataHomeTvState{nowPlayingTv: ${tState.nowPlayingTv}, popularTv: ${tState.popularTv}, '
              'topRatedTv: ${tState.topRatedTv}}',
        );
      },
    );
  });

  group('SuccessLoadDataNowPlayingTvState', () {
    final tState = SuccessLoadDataNowPlayingTvState(nowPlayingTv: testTvList);

    test(
      'make sure output toString function',
          () async {
        // act
        final result = tState.toString();

        // assert
        expect(
          result,
          'SuccessLoadDataNowPlayingTvState{nowPlayingTv: ${tState.nowPlayingTv}}',
        );
      },
    );
  });

  group('SuccessLoadDataPopularTvState', () {
    final tState = SuccessLoadDataPopularTvState(popularTv: testTvList);

    test(
      'make sure output toString function',
          () async {
        // act
        final result = tState.toString();

        // assert
        expect(
          result,
          'SuccessLoadDataPopularTvState{popularTv: ${tState.popularTv}}',
        );
      },
    );
  });

  group('SuccessLoadDataTopRatedTvState', () {
    final tState = SuccessLoadDataTopRatedTvState(topRatedTv: testTvList);

    test(
      'make sure output toString function',
          () async {
        // act
        final result = tState.toString();

        // assert
        expect(result, 'SuccessLoadDataTopRatedTvState{topRatedTv: ${tState.topRatedTv}}');
      },
    );
  });

  group('SuccessLoadDataDetailTvState', () {
    final tState = SuccessLoadDataDetailTvState(
      tvDetail: testTvDetail,
      tvRecommendations: testTvList,
    );

    test(
      'make sure output toString function',
          () async {
        // act
        final result = tState.toString();

        // assert
        expect(
          result,
          'SuccessLoadDataDetailTvState{movieDetail: ${tState.tvDetail}, '
              'movieRecommendations: ${tState.tvRecommendations}}',
        );
      },
    );
  });

  group('SuccessSearchTvState', () {
    final tState = SuccessSearchTvState(searchResult: testTvList);

    test(
      'make sure output toString function',
          () async {
        // act
        final result = tState.toString();

        // assert
        expect(result, 'SuccessSearchTvState{searchResult: ${tState.searchResult}}');
      },
    );
  });
}
