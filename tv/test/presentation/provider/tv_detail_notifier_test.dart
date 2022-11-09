import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
import 'package:tv/domain/usecases/get_watchlist_status_tv.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_watchlist_tv.dart';
import 'package:tv/presentation/provider/tv_detail_notifier.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetWatchlistStatusTv,
  SaveWatchlistTv,
  RemoveWatchlistTv,
])
void main() {
  late TvDetailNotifier provider;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetWatchlistStatusTv mockGetWatchlistStatusTv;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetWatchlistStatusTv = MockGetWatchlistStatusTv();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    provider = TvDetailNotifier(
      getTvDetail: mockGetTvDetail,
      getTvRecommendations: mockGetTvRecommendations,
      getWatchlistStatusTv: mockGetWatchlistStatusTv,
      saveWatchlistTv: mockSaveWatchlistTv,
      removeWatchlistTv: mockRemoveWatchlistTv,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  const tId = 1;
  final tTv = Tv(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: const [1, 2],
    id: 1,
    name: 'name',
    originalCountry: const ['originalCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    voteAverage: 1.0,
    voteCount: 1,
  );
  final tTvs = <Tv>[tTv];

  void arrangeUsecase() {
    when(mockGetTvDetail.execute(tId)).thenAnswer((_) async => const Right(testTvDetail));
    when(mockGetTvRecommendations.execute(tId)).thenAnswer((_) async => Right(tTvs));
  }

  group('get tv detail', () {
    test(
      'should get data from the usecase',
      () async {
        // arrange
        arrangeUsecase();

        // act
        await provider.fetchTvDetail(tId);

        // assert
        verify(mockGetTvDetail.execute(tId));
        verify(mockGetTvRecommendations.execute(tId));
      },
    );

    test(
      'should change state to Loading when usecase is called',
      () async {
        // arrange
        arrangeUsecase();

        // act
        provider.fetchTvDetail(tId);

        // assert
        expect(provider.tvState, RequestState.loading);
        expect(listenerCallCount, 1);
      },
    );

    test(
      'should change tv when data is gotten successfully',
      () async {
        // arrange
        arrangeUsecase();

        // act
        await provider.fetchTvDetail(tId);

        // assert
        expect(provider.tvState, RequestState.loaded);
        expect(provider.tv, testTvDetail);
        expect(listenerCallCount, 3);
      },
    );

    test(
      'should change recommendation tv when data is gotten successfully',
      () async {
        // arrange
        arrangeUsecase();

        // act
        await provider.fetchTvDetail(tId);

        // assert
        expect(provider.tvState, RequestState.loaded);
        expect(provider.tvRecommendations, tTvs);
      },
    );
  });

  group('get tv recommendations', () {
    test(
      'should get data from the usecase',
      () async {
        // arrange
        arrangeUsecase();

        // act
        await provider.fetchTvDetail(tId);

        // assert
        verify(mockGetTvRecommendations.execute(tId));
        expect(provider.tvRecommendations, tTvs);
      },
    );

    test(
      'should update recommendation state when data is gotten successfully',
      () async {
        // arrange
        arrangeUsecase();

        // act
        await provider.fetchTvDetail(tId);

        // assert
        expect(provider.recommendationState, RequestState.loaded);
        expect(provider.tvRecommendations, tTvs);
      },
    );

    test(
      'should update error message when request is successful',
      () async {
        // arrange
        when(mockGetTvDetail.execute(tId)).thenAnswer((_) async => const Right(testTvDetail));
        when(mockGetTvRecommendations.execute(tId)).thenAnswer((_) async => Left(ServerFailure('Failed')));

        // act
        await provider.fetchTvDetail(tId);

        // assert
        expect(provider.recommendationState, RequestState.error);
        expect(provider.message, 'Failed');
      },
    );
  });

  group('watchlist', () {
    test(
      'should get the watchlist status',
      () async {
        // arrange
        when(mockGetWatchlistStatusTv.execute(1)).thenAnswer((_) async => true);

        // act
        await provider.loadWatchlistStatus(1);

        // assert
        expect(provider.isAddedToWatchlist, true);
      },
    );

    test(
      'should execute save watchlist when function called',
      () async {
        // arrange
        when(mockSaveWatchlistTv.execute(testTvDetail)).thenAnswer((_) async => const Right('Success'));
        when(mockGetWatchlistStatusTv.execute(testTvDetail.id)).thenAnswer((_) async => true);

        // act
        await provider.addWatchlist(testTvDetail);

        // assert
        verify(mockSaveWatchlistTv.execute(testTvDetail));
      },
    );

    test(
      'should execute remove watchlist when function called',
      () async {
        // arrange
        when(mockRemoveWatchlistTv.execute(testTvDetail)).thenAnswer((_) async => const Right('Removed'));
        when(mockGetWatchlistStatusTv.execute(testTvDetail.id)).thenAnswer((_) async => false);

        // act
        await provider.removeFromWatchlist(testTvDetail);

        // assert
        verify(mockRemoveWatchlistTv.execute(testTvDetail));
      },
    );

    test(
      'should execute get watch list status when remove watchlist is unsuccessful',
      () async {
        // arrange
        when(mockRemoveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(mockGetWatchlistStatusTv.execute(testTvDetail.id)).thenAnswer((_) async => false);

        // act
        await provider.removeFromWatchlist(testTvDetail);

        // assert
        verify(mockRemoveWatchlistTv.execute(testTvDetail));
      },
    );

    test(
      'should update watchlist status when add watchlist success',
      () async {
        // arrange
        when(mockSaveWatchlistTv.execute(testTvDetail)).thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetWatchlistStatusTv.execute(testTvDetail.id)).thenAnswer((_) async => true);

        // act
        await provider.addWatchlist(testTvDetail);

        // assert
        verify(mockGetWatchlistStatusTv.execute(testTvDetail.id));
        expect(provider.isAddedToWatchlist, true);
        expect(provider.watchlistMessage, 'Added to Watchlist');
        expect(listenerCallCount, 1);
      },
    );

    test(
      'should update watchlist message when add watchlist failed',
      () async {
        // arrange
        when(mockSaveWatchlistTv.execute(testTvDetail)).thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistStatusTv.execute(testTvDetail.id)).thenAnswer((_) async => false);

        // act
        await provider.addWatchlist(testTvDetail);

        // assert
        expect(provider.watchlistMessage, 'Failed');
        expect(listenerCallCount, 1);
      },
    );
  });

  group('on error', () {
    test(
      'should return error when data is unsuccessful',
      () async {
        // arrange
        when(mockGetTvDetail.execute(tId)).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(mockGetTvRecommendations.execute(tId)).thenAnswer((_) async => Right(tTvs));

        // act
        await provider.fetchTvDetail(tId);

        // assert
        expect(provider.tvState, RequestState.error);
        expect(provider.message, 'Server Failure');
        expect(listenerCallCount, 2);
      },
    );
  });
}
