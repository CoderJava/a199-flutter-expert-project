import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
import 'package:tv/presentation/provider/top_rated_tv_notifier.dart';

import 'top_rated_tv_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTv])
void main() {
  late TopRatedTvNotifier provider;
  late MockGetTopRatedTv mockGetTopRatedTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedTv = MockGetTopRatedTv();
    provider = TopRatedTvNotifier(getTopRatedTv: mockGetTopRatedTv)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

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
  final tTvList = <Tv>[tTv];

  test(
    'should change state to loading when usecase is called',
    () async {
      // arrange
      when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(tTvList));

      // act
      provider.fetchTopRatedTv();

      // assert
      expect(provider.state, RequestState.loading);
      expect(listenerCallCount, 1);
    },
  );

  test(
    'should change tv data when data is gotten successfully',
    () async {
      // arrange
      when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(tTvList));

      // act
      await provider.fetchTopRatedTv();

      // assert
      expect(provider.state, RequestState.loaded);
      expect(provider.tv, tTvList);
      expect(listenerCallCount, 2);
    },
  );

  test(
    'should return error when data is unsuccessful',
    () async {
      // arrange
      when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      // act
      await provider.fetchTopRatedTv();

      // assert
      expect(provider.state, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    },
  );
}
