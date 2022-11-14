import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/movie_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieBloc bloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatusMovie mockGetWatchListStatusMovie;
  late MockSaveWatchlistMovie mockSaveWatchlistMovie;
  late MockRemoveWatchlistMovie mockRemoveWatchlistMovie;
  late MockSearchMovies mockSearchMovies;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchListStatusMovie = MockGetWatchListStatusMovie();
    mockSaveWatchlistMovie = MockSaveWatchlistMovie();
    mockRemoveWatchlistMovie = MockRemoveWatchlistMovie();
    mockSearchMovies = MockSearchMovies();
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    bloc = MovieBloc(
      getNowPlayingMovies: mockGetNowPlayingMovies,
      getPopularMovies: mockGetPopularMovies,
      getTopRatedMovies: mockGetTopRatedMovies,
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListStatusMovie: mockGetWatchListStatusMovie,
      saveWatchlistMovie: mockSaveWatchlistMovie,
      removeWatchlistMovie: mockRemoveWatchlistMovie,
      searchMovies: mockSearchMovies,
      getWatchlistMovies: mockGetWatchlistMovies,
    );
  });

  const tMessage = 'message';

  test(
    'make sure output of initialState',
    () async {
      // assert
      expect(bloc.state, isA<InitialMovieState>());
    },
  );

  group('load data home movie', () {
    final tEvent = LoadDataHomeMovieEvent();

    blocTest(
      'should emit [LoadingMovieState, SuccessLoadDataHomeMovieState] when all process is success',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer((_) async => Right(testMovieList));
        when(mockGetPopularMovies.execute()).thenAnswer((_) async => Right(testMovieList));
        when(mockGetTopRatedMovies.execute()).thenAnswer((_) async => Right(testMovieList));
        return bloc;
      },
      act: (MovieBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<LoadingMovieState>(),
        isA<SuccessLoadDataHomeMovieState>(),
      ],
      verify: (_) {
        verify(mockGetNowPlayingMovies.execute());
        verify(mockGetPopularMovies.execute());
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest(
      'should emit [LoadingMovieState, FailureMovieState] when failure get now playing movies',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer((_) async => Left(ServerFailure(tMessage)));
        return bloc;
      },
      act: (MovieBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<LoadingMovieState>(),
        isA<FailureMovieState>(),
      ],
      verify: (_) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest(
      'should emit [LoadingMovieState, FailureMovieState] when failure get popular movies',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer((_) async => Right(testMovieList));
        when(mockGetPopularMovies.execute()).thenAnswer((_) async => Left(ServerFailure(tMessage)));
        return bloc;
      },
      act: (MovieBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<LoadingMovieState>(),
        isA<FailureMovieState>(),
      ],
      verify: (_) {
        verify(mockGetNowPlayingMovies.execute());
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest(
      'should emit [LoadingMovieState, FailureMovieState] when failure get top rated movies',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer((_) async => Right(testMovieList));
        when(mockGetPopularMovies.execute()).thenAnswer((_) async => Right(testMovieList));
        when(mockGetTopRatedMovies.execute()).thenAnswer((_) async => Left(ServerFailure(tMessage)));
        return bloc;
      },
      act: (MovieBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<LoadingMovieState>(),
        isA<FailureMovieState>(),
      ],
      verify: (_) {
        verify(mockGetNowPlayingMovies.execute());
        verify(mockGetPopularMovies.execute());
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });

  group('load data now playing movie', () {
    final tEvent = LoadDataNowPlayingMovieEvent();

    blocTest(
      'should emit [LoadingMovieState, SuccessLoadDataNowPlayingMovieState] when success get now playing movies',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer((_) async => Right(testMovieList));
        return bloc;
      },
      act: (MovieBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<LoadingMovieState>(),
        isA<SuccessLoadDataNowPlayingMovieState>(),
      ],
      verify: (_) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest(
      'should emit [LoadingMovieState, FailureMovieState] when failure get now playing movies',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer((_) async => Left(ServerFailure(tMessage)));
        return bloc;
      },
      act: (MovieBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<LoadingMovieState>(),
        isA<FailureMovieState>(),
      ],
      verify: (_) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });

  group('load data popular movie', () {
    final tEvent = LoadDataPopularMovieEvent();

    blocTest(
      'should emit [LoadingMovieState, SuccessLoadDataPopularMovieState] when success get popular movies',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer((_) async => Right(testMovieList));
        return bloc;
      },
      act: (MovieBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<LoadingMovieState>(),
        isA<SuccessLoadDataPopularMovieState>(),
      ],
      verify: (_) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest(
      'should emit [LoadingMovieState, FailureMovieState] when failure get popular movies',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer((_) async => Left(ServerFailure(tMessage)));
        return bloc;
      },
      act: (MovieBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<LoadingMovieState>(),
        isA<FailureMovieState>(),
      ],
      verify: (_) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });

  group('load data top rated movie', () {
    final tEvent = LoadDataTopRatedMovieEvent();

    blocTest(
      'should emit [LoadingMovieState, SuccessLoadDataTopRatedMovieState] when success get top rated movies',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer((_) async => Right(testMovieList));
        return bloc;
      },
      act: (MovieBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<LoadingMovieState>(),
        isA<SuccessLoadDataTopRatedMovieState>(),
      ],
      verify: (_) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest(
      'should emit [LoadingMovieState, FailureMovieState] when failure get top rated movies',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer((_) async => Left(ServerFailure(tMessage)));
        return bloc;
      },
      act: (MovieBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<LoadingMovieState>(),
        isA<FailureMovieState>(),
      ],
      verify: (_) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });

  group('load data detail movie', () {
    const tId = 1;
    final tEvent = LoadDataDetailMovieEvent(id: tId);

    blocTest(
      'should emit [LoadingMovieState, SuccessLoadDataDetailMovieState] when all process is success',
      build: () {
        when(mockGetMovieDetail.execute(tId)).thenAnswer((_) async => const Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId)).thenAnswer((_) async => Right(testMovieList));
        return bloc;
      },
      act: (MovieBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<LoadingMovieState>(),
        isA<SuccessLoadDataDetailMovieState>(),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest(
      'should emit [LoadingMovieState, FailureMovieState] when failure get movie detail',
      build: () {
        when(mockGetMovieDetail.execute(tId)).thenAnswer((_) async => Left(ServerFailure(tMessage)));
        return bloc;
      },
      act: (MovieBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<LoadingMovieState>(),
        isA<FailureMovieState>(),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );

    blocTest(
      'should emit [LoadingMovieState, FailureMovieState] when failure get movie recommendations',
      build: () {
        when(mockGetMovieDetail.execute(tId)).thenAnswer((_) async => const Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId)).thenAnswer((_) async => Left(ServerFailure(tMessage)));
        return bloc;
      },
      act: (MovieBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<LoadingMovieState>(),
        isA<FailureMovieState>(),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );
  });

  group('search movie', () {
    const tQuery = 'query';
    final tEvent = SearchMovieEvent(query: tQuery);

    blocTest(
      'should emit [LoadingMovieState, SuccessSearchMovieState] when success search get movies',
      build: () {
        when(mockSearchMovies.execute(tQuery)).thenAnswer((_) async => Right(testMovieList));
        return bloc;
      },
      act: (MovieBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<LoadingMovieState>(),
        isA<SuccessSearchMovieState>(),
      ],
      verify: (_) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );

    blocTest(
      'should emit [LoadingMovieState, FailureMovieState] when failure search get movies',
      build: () {
        when(mockSearchMovies.execute(tQuery)).thenAnswer((_) async => Left(ServerFailure(tMessage)));
        return bloc;
      },
      act: (MovieBloc bloc) {
        return bloc.add(tEvent);
      },
      expect: () => [
        isA<LoadingMovieState>(),
        isA<FailureMovieState>(),
      ],
      verify: (_) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );
  });
}
