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

  group('load data home movie', () {
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
      'should emit [LoadingTvState, FailureTvState] when failure get now playing movies',
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
      'should emit [LoadingTvState, FailureTvState] when failure get popular movies',
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
      'should emit [LoadingTvState, FailureTvState] when failure get top rated movies',
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

  group('load data now playing movie', () {
    final tEvent = LoadDataNowPlayingTvEvent();

    blocTest(
      'should emit [LoadingTvState, SuccessLoadDataNowPlayingTvState] when success get now playing movies',
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
      'should emit [LoadingTvState, FailureTvState] when failure get now playing movies',
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

  group('load data popular movie', () {
    final tEvent = LoadDataPopularTvEvent();

    blocTest(
      'should emit [LoadingTvState, SuccessLoadDataPopularTvState] when success get popular movies',
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
      'should emit [LoadingTvState, FailureTvState] when failure get popular movies',
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

  group('load data top rated movie', () {
    final tEvent = LoadDataTopRatedTvEvent();

    blocTest(
      'should emit [LoadingTvState, SuccessLoadDataTopRatedTvState] when success get top rated movies',
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
      'should emit [LoadingTvState, FailureTvState] when failure get top rated movies',
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

  group('load data detail movie', () {
    const tId = 1;
    final tEvent = LoadDataDetailTvEvent(id: tId);

    blocTest(
      'should emit [LoadingTvState, SuccessLoadDataDetailTvState] when all process is success',
      build: () {
        when(mockGetTvDetail.execute(tId)).thenAnswer((_) async => const Right(testTvDetail));
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
        verify(mockGetTvRecommendations.execute(tId));
      },
    );

    blocTest(
      'should emit [LoadingTvState, FailureTvState] when failure get movie detail',
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
      'should emit [LoadingTvState, FailureTvState] when failure get movie recommendations',
      build: () {
        when(mockGetTvDetail.execute(tId)).thenAnswer((_) async => const Right(testTvDetail));
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
        verify(mockGetTvRecommendations.execute(tId));
      },
    );
  });

  group('search movie', () {
    const tQuery = 'query';
    final tEvent = SearchTvEvent(query: tQuery);

    blocTest(
      'should emit [LoadingTvState, SuccessSearchTvState] when success search get movies',
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
      'should emit [LoadingTvState, FailureTvState] when failure search get movies',
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
}
