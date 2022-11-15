import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/tv_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvBloc bloc;
  late MockGetNowPlayingTv mockGetNowPlayingTv;
  late MockGetPopularTv mockGetPopularTv;
  late MockGetTopRatedTv mockGetTopRatedTv;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetWatchlistStatusTv mockGetWatchListStatusTv;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;
  late MockSearchTv mockSearchTv;
  late MockGetWatchlistTv mockGetWatchlistTv;

  setUp(() {
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    mockGetPopularTv = MockGetPopularTv();
    mockGetTopRatedTv = MockGetTopRatedTv();
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetWatchListStatusTv = MockGetWatchlistStatusTv();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    mockSearchTv = MockSearchTv();
    mockGetWatchlistTv = MockGetWatchlistTv();
    bloc = TvBloc(
      getNowPlayingTv: mockGetNowPlayingTv,
      getPopularTv: mockGetPopularTv,
      getTopRatedTv: mockGetTopRatedTv,
      getTvDetail: mockGetTvDetail,
      getTvRecommendations: mockGetTvRecommendations,
      getWatchListStatusTv: mockGetWatchListStatusTv,
      saveWatchlistTv: mockSaveWatchlistTv,
      removeWatchlistTv: mockRemoveWatchlistTv,
      searchTv: mockSearchTv,
      getWatchlistTv: mockGetWatchlistTv,
    );
  });

  const tMessage = 'message';

  test(
    'make sure output of initialState',
    () async {
      // assert
      expect(bloc.state, isA<InitialTvState>());
    },
  );

  group('load data home tv', () {
    final tEvent = LoadDataHomeTvEvent();

    blocTest(
      'should emit [LoadingTvState, SuccessLoadDataHomeTvState] when all process is success',
      build: () {
        when(mockGetNowPlayingTv.execute()).thenAnswer((_) async => Right(testTvList));
        when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(testTvList));
        when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(testTvList));
        return bloc;
      },
      act: (TvBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<LoadingTvState>(),
        isA<SuccessLoadDataHomeTvState>(),
      ],
      verify: (_) {
        verify(mockGetNowPlayingTv.execute());
        verify(mockGetPopularTv.execute());
        verify(mockGetTopRatedTv.execute());
      },
    );

    blocTest(
      'should emit [LoadingTvState, FailureTvState] when failure get now playing tv',
      build: () {
        when(mockGetNowPlayingTv.execute()).thenAnswer((_) async => Left(ServerFailure(tMessage)));
        return bloc;
      },
      act: (TvBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<LoadingTvState>(),
        isA<FailureTvState>(),
      ],
      verify: (_) {
        verify(mockGetNowPlayingTv.execute());
      },
    );

    blocTest(
      'should emit [LoadingTvState, FailureTvState] when failure get popular tv',
      build: () {
        when(mockGetNowPlayingTv.execute()).thenAnswer((_) async => Right(testTvList));
        when(mockGetPopularTv.execute()).thenAnswer((_) async => Left(ServerFailure(tMessage)));
        return bloc;
      },
      act: (TvBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<LoadingTvState>(),
        isA<FailureTvState>(),
      ],
      verify: (_) {
        verify(mockGetNowPlayingTv.execute());
        verify(mockGetPopularTv.execute());
      },
    );

    blocTest(
      'should emit [LoadingTvState, FailureTvState] when failure get top rated tv',
      build: () {
        when(mockGetNowPlayingTv.execute()).thenAnswer((_) async => Right(testTvList));
        when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(testTvList));
        when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Left(ServerFailure(tMessage)));
        return bloc;
      },
      act: (TvBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<LoadingTvState>(),
        isA<FailureTvState>(),
      ],
      verify: (_) {
        verify(mockGetNowPlayingTv.execute());
        verify(mockGetPopularTv.execute());
        verify(mockGetTopRatedTv.execute());
      },
    );
  });

  group('load data now playing tv', () {
    final tEvent = LoadDataNowPlayingTvEvent();

    blocTest(
      'should emit [LoadingTvState, SuccessLoadDataNowPlayingTvState] when success get now playing tv',
      build: () {
        when(mockGetNowPlayingTv.execute()).thenAnswer((_) async => Right(testTvList));
        return bloc;
      },
      act: (TvBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<LoadingTvState>(),
        isA<SuccessLoadDataNowPlayingTvState>(),
      ],
      verify: (_) {
        verify(mockGetNowPlayingTv.execute());
      },
    );

    blocTest(
      'should emit [LoadingTvState, FailureTvState] when failure get now playing tv',
      build: () {
        when(mockGetNowPlayingTv.execute()).thenAnswer((_) async => Left(ServerFailure(tMessage)));
        return bloc;
      },
      act: (TvBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<LoadingTvState>(),
        isA<FailureTvState>(),
      ],
      verify: (_) {
        verify(mockGetNowPlayingTv.execute());
      },
    );
  });

  group('load data popular tv', () {
    final tEvent = LoadDataPopularTvEvent();

    blocTest(
      'should emit [LoadingTvState, SuccessLoadDataPopularTvState] when success get popular tv',
      build: () {
        when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(testTvList));
        return bloc;
      },
      act: (TvBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<LoadingTvState>(),
        isA<SuccessLoadDataPopularTvState>(),
      ],
      verify: (_) {
        verify(mockGetPopularTv.execute());
      },
    );

    blocTest(
      'should emit [LoadingTvState, FailureTvState] when failure get popular tv',
      build: () {
        when(mockGetPopularTv.execute()).thenAnswer((_) async => Left(ServerFailure(tMessage)));
        return bloc;
      },
      act: (TvBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<LoadingTvState>(),
        isA<FailureTvState>(),
      ],
      verify: (_) {
        verify(mockGetPopularTv.execute());
      },
    );
  });

  group('load data top rated tv', () {
    final tEvent = LoadDataTopRatedTvEvent();

    blocTest(
      'should emit [LoadingTvState, SuccessLoadDataTopRatedTvState] when success get top rated tv',
      build: () {
        when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(testTvList));
        return bloc;
      },
      act: (TvBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<LoadingTvState>(),
        isA<SuccessLoadDataTopRatedTvState>(),
      ],
      verify: (_) {
        verify(mockGetTopRatedTv.execute());
      },
    );

    blocTest(
      'should emit [LoadingTvState, FailureTvState] when failure get top rated tv',
      build: () {
        when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Left(ServerFailure(tMessage)));
        return bloc;
      },
      act: (TvBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<LoadingTvState>(),
        isA<FailureTvState>(),
      ],
      verify: (_) {
        verify(mockGetTopRatedTv.execute());
      },
    );
  });

  group('load data detail tv', () {
    const tId = 1;
    final tEvent = LoadDataDetailTvEvent(id: tId);

    blocTest(
      'should emit [LoadingTvState, SuccessLoadDataDetailTvState] when all process is success',
      build: () {
        when(mockGetTvDetail.execute(tId)).thenAnswer((_) async => const Right(testTvDetail));
        when(mockGetWatchListStatusTv.execute(tId)).thenAnswer((_) async => true);
        when(mockGetTvRecommendations.execute(tId)).thenAnswer((_) async => Right(testTvList));
        return bloc;
      },
      act: (TvBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<LoadingTvState>(),
        isA<SuccessLoadDataDetailTvState>(),
      ],
      verify: (_) {
        verify(mockGetTvDetail.execute(tId));
        verify(mockGetWatchListStatusTv.execute(tId));
        verify(mockGetTvRecommendations.execute(tId));
      },
    );

    blocTest(
      'should emit [LoadingTvState, FailureTvState] when failure get tv detail',
      build: () {
        when(mockGetTvDetail.execute(tId)).thenAnswer((_) async => Left(ServerFailure(tMessage)));
        return bloc;
      },
      act: (TvBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<LoadingTvState>(),
        isA<FailureTvState>(),
      ],
      verify: (_) {
        verify(mockGetTvDetail.execute(tId));
      },
    );

    blocTest(
      'should emit [LoadingTvState, FailureTvState] when failure get tv recommendations',
      build: () {
        when(mockGetTvDetail.execute(tId)).thenAnswer((_) async => const Right(testTvDetail));
        when(mockGetWatchListStatusTv.execute(tId)).thenAnswer((_) async => true);
        when(mockGetTvRecommendations.execute(tId)).thenAnswer((_) async => Left(ServerFailure(tMessage)));
        return bloc;
      },
      act: (TvBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<LoadingTvState>(),
        isA<FailureTvState>(),
      ],
      verify: (_) {
        verify(mockGetTvDetail.execute(tId));
        verify(mockGetWatchListStatusTv.execute(tId));
        verify(mockGetTvRecommendations.execute(tId));
      },
    );
  });

  group('search tv', () {
    const tQuery = 'query';
    final tEvent = SearchTvEvent(query: tQuery);

    blocTest(
      'should emit [LoadingTvState, SuccessSearchTvState] when success search get tv',
      build: () {
        when(mockSearchTv.execute(tQuery)).thenAnswer((_) async => Right(testTvList));
        return bloc;
      },
      act: (TvBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<LoadingTvState>(),
        isA<SuccessSearchTvState>(),
      ],
      verify: (_) {
        verify(mockSearchTv.execute(tQuery));
      },
    );

    blocTest(
      'should emit [LoadingTvState, FailureTvState] when failure search get tv',
      build: () {
        when(mockSearchTv.execute(tQuery)).thenAnswer((_) async => Left(ServerFailure(tMessage)));
        return bloc;
      },
      act: (TvBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<LoadingTvState>(),
        isA<FailureTvState>(),
      ],
      verify: (_) {
        verify(mockSearchTv.execute(tQuery));
      },
    );
  });

  group('load data watchlist tv', () {
    final tEvent = LoadDataWatchlistTvEvent();

    blocTest(
      'should emit [SuccessLoadDataWatchlistTvState] when success load data watchlist tv',
      build: () {
        when(mockGetWatchlistTv.execute()).thenAnswer((_) async => Right(testTvList));
        return bloc;
      },
      act: (TvBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<SuccessLoadDataWatchlistTvState>(),
      ],
      verify: (_) {
        verify(mockGetWatchlistTv.execute());
      },
    );

    blocTest(
      'should emit [SuccessLoadDataWatchlistTvState] when failure load data watchlist tv',
      build: () {
        when(mockGetWatchlistTv.execute()).thenAnswer((_) async => Left(ServerFailure(tMessage)));
        return bloc;
      },
      act: (TvBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<FailureTvState>(),
      ],
      verify: (_) {
        verify(mockGetWatchlistTv.execute());
      },
    );
  });

  group('add watchlist tv', () {
    final tEvent = AddWatchlistTvEvent(tv: testTvDetail);

    blocTest(
      'should emit [SuccessUpdateWatchlistStatusTvState] when success added to watchlist tv',
      build: () {
        when(mockSaveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => const Right(TvBloc.watchlistAddSuccessMessage));
        when(mockGetWatchListStatusTv.execute(testTvDetail.id)).thenAnswer((_) async => true);
        return bloc;
      },
      act: (TvBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<SuccessUpdateWatchlistStatusTvState>(),
      ],
      verify: (_) {
        verify(mockSaveWatchlistTv.execute(testTvDetail));
        verify(mockGetWatchListStatusTv.execute(testTvDetail.id));
      },
    );

    blocTest(
      'should emit [SuccessUpdateWatchlistStatusTvState] when failure added to watchlist tv',
      build: () {
        when(mockSaveWatchlistTv.execute(testTvDetail)).thenAnswer((_) async => Left(DatabaseFailure(tMessage)));
        when(mockGetWatchListStatusTv.execute(testTvDetail.id)).thenAnswer((_) async => false);
        return bloc;
      },
      act: (TvBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<SuccessUpdateWatchlistStatusTvState>(),
      ],
      verify: (_) {
        verify(mockSaveWatchlistTv.execute(testTvDetail));
        verify(mockGetWatchListStatusTv.execute(testTvDetail.id));
      },
    );
  });

  group('remove watchlist tv', () {
    final tEvent = RemoveWatchlistTvEvent(tv: testTvDetail);

    blocTest(
      'should emit [SuccessUpdateWatchlistStatusTvState] when success remove from watchlist tv',
      build: () {
        when(mockRemoveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => const Right(TvBloc.watchlistRemoveSuccessMessage));
        when(mockGetWatchListStatusTv.execute(testTvDetail.id)).thenAnswer((_) async => false);
        return bloc;
      },
      act: (TvBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<SuccessUpdateWatchlistStatusTvState>(),
      ],
      verify: (_) {
        verify(mockRemoveWatchlistTv.execute(testTvDetail));
        verify(mockGetWatchListStatusTv.execute(testTvDetail.id));
      },
    );

    blocTest(
      'should emit [SuccessUpdateWatchlistStatusTvState] when failure remove from watchlist tv',
      build: () {
        when(mockRemoveWatchlistTv.execute(testTvDetail)).thenAnswer((_) async => Left(DatabaseFailure(tMessage)));
        when(mockGetWatchListStatusTv.execute(testTvDetail.id)).thenAnswer((_) async => true);
        return bloc;
      },
      act: (TvBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<SuccessUpdateWatchlistStatusTvState>(),
      ],
      verify: (_) {
        verify(mockRemoveWatchlistTv.execute(testTvDetail));
        verify(mockGetWatchListStatusTv.execute(testTvDetail.id));
      },
    );
  });
}
