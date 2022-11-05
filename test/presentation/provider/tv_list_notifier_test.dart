import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:ditonton/presentation/provider/tv_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingTv,
  GetPopularTv,
  GetTopRatedTv,
])
void main() {
  late TvListNotifier provider;
  late MockGetNowPlayingTv mockGetNowPlayingTv;
  late MockGetPopularTv mockGetPopularTv;
  late MockGetTopRatedTv mockGetTopRatedTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    mockGetPopularTv = MockGetPopularTv();
    mockGetTopRatedTv = MockGetTopRatedTv();
    provider = TvListNotifier(
      getNowPlayingTv: mockGetNowPlayingTv,
      getPopularTv: mockGetPopularTv,
      getTopRatedTv: mockGetTopRatedTv,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTv = Tv(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2],
    id: 1,
    name: 'name',
    originalCountry: [
      'originalCountry',
    ],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    voteAverage: 1.0,
    voteCount: 1,
  );
  final tTvList = <Tv>[tTv];
  const tServerFailureMessage = 'Server Failure';

  group('now playing tv', () {
    test(
      'initialState should be empty',
      () async {
        // assert
        expect(provider.nowPlayingState, equals(RequestState.Empty));
      },
    );

    test(
      'should get data from the usecase',
      () async {
        // arrange
        when(mockGetNowPlayingTv.execute()).thenAnswer((_) async => Right(tTvList));

        // act
        provider.fetchNowPlayingTv();

        // assert
        verify(mockGetNowPlayingTv.execute());
      },
    );

    test(
      'should change state to Loading when usecase is called',
      () async {
        // arrange
        when(mockGetNowPlayingTv.execute()).thenAnswer((_) async => Right(tTvList));

        // act
        provider.fetchNowPlayingTv();

        // assert
        expect(provider.nowPlayingState, RequestState.Loading);
      },
    );

    test(
      'should change tv when data is gotten successfully',
      () async {
        // arrange
        when(mockGetNowPlayingTv.execute()).thenAnswer((_) async => Right(tTvList));

        // act
        await provider.fetchNowPlayingTv();

        // assert
        expect(provider.nowPlayingState, RequestState.Loaded);
        expect(provider.nowPlayingtv, tTvList);
        expect(listenerCallCount, 2);
      },
    );

    test(
      'should return error when data is unsuccessful',
      () async {
        // arrange
        when(mockGetNowPlayingTv.execute()).thenAnswer((_) async => Left(ServerFailure(tServerFailureMessage)));

        // act
        await provider.fetchNowPlayingTv();

        // assert
        expect(provider.nowPlayingState, RequestState.Error);
        expect(provider.message, tServerFailureMessage);
        expect(listenerCallCount, 2);
      },
    );
  });

  group('popular tv', () {
    test(
      'should change state to loading loading when usecase is called',
      () async {
        // arrange
        when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(tTvList));

        // act
        provider.fetchPopularTv();

        // assert
        expect(provider.popularTvState, RequestState.Loading);
      },
    );

    test(
      'should change tv data when data is gotten successfully',
      () async {
        // arrange
        when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(tTvList));

        // act
        await provider.fetchPopularTv();

        // assert
        expect(provider.popularTvState, RequestState.Loaded);
        expect(provider.popularTv, tTvList);
        expect(listenerCallCount, 2);
      },
    );

    test(
      'should return error when data is unsuccessful',
      () async {
        // arrange
        when(mockGetPopularTv.execute()).thenAnswer((_) async => Left(ServerFailure(tServerFailureMessage)));

        // act
        await provider.fetchPopularTv();

        // assert
        expect(provider.popularTvState, RequestState.Error);
        expect(provider.message, tServerFailureMessage);
        expect(listenerCallCount, 2);
      },
    );
  });

  group('top rated tv', () {
    test(
      'should change state to loading when usecase is called',
      () async {
        // arrange
        when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(tTvList));

        // act
        provider.fetchTopRatedTv();

        // assert
        expect(provider.topRatedTvState, RequestState.Loading);
      },
    );

    test(
      'should change tv data when is gotten successfully',
      () async {
        // arrange
        when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(tTvList));

        // act
        await provider.fetchTopRatedTv();

        // assert
        expect(provider.topRatedTvState, RequestState.Loaded);
        expect(provider.topRatedTv, tTvList);
        expect(listenerCallCount, 2);
      },
    );

    test(
      'should return error when data is unsuccessful',
      () async {
        // arrange
        when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Left(ServerFailure(tServerFailureMessage)));

        // act
        await provider.fetchTopRatedTv();

        // assert
        expect(provider.topRatedTvState, RequestState.Error);
        expect(provider.message, tServerFailureMessage);
        expect(listenerCallCount, 2);
      },
    );
  });
}