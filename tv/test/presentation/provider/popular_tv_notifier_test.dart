import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:tv/presentation/provider/popular_tv_notifier.dart';

import 'popular_tv_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late PopularTvNotifier provider;
  late MockGetPopularTv mockGetPopularTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTv = MockGetPopularTv();
    provider = PopularTvNotifier(getPopularTv: mockGetPopularTv)
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
      when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(tTvList));

      // act
      provider.fetchPopularTv();

      // assert
      expect(provider.state, RequestState.loading);
      expect(listenerCallCount, 1);
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
      expect(provider.state, RequestState.loaded);
      expect(provider.tv, tTvList);
      expect(listenerCallCount, 2);
    },
  );

  test(
    'should return error when data is unsuccessful',
    () async {
      // arrange
      when(mockGetPopularTv.execute()).thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      // act
      await provider.fetchPopularTv();

      // assert
      expect(provider.state, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    },
  );
}
