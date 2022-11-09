import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/search_tv.dart';
import 'package:tv/presentation/provider/tv_search_notifier.dart';

import 'tv_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTv])
void main() {
  late TvSearchNotifier provider;
  late MockSearchTv mockSearchTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTv = MockSearchTv();
    provider = TvSearchNotifier(searchTv: mockSearchTv)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTvModel = Tv(
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
  final tTvList = <Tv>[tTvModel];
  const tQuery = 'query';

  group('search tv', () {
    test(
      'should change state to loading when usecase is called',
      () async {
        // arrange
        when(mockSearchTv.execute(tQuery)).thenAnswer((_) async => Right(tTvList));

        // act
        provider.fetchTvSearch(tQuery);

        // assert
        expect(provider.state, RequestState.loading);
      },
    );

    test(
      'should change search result data when data is gotten successfully',
      () async {
        // arrange
        when(mockSearchTv.execute(tQuery)).thenAnswer((_) async => Right(tTvList));

        // act
        await provider.fetchTvSearch(tQuery);

        // assert
        expect(provider.state, RequestState.loaded);
        expect(provider.searchResult, tTvList);
        expect(listenerCallCount, 2);
      },
    );

    test(
      'should return error when data is unsuccessful',
      () async {
        // arrange
        when(mockSearchTv.execute(tQuery)).thenAnswer((_) async => Left(ServerFailure('Server Failure')));

        // act
        await provider.fetchTvSearch(tQuery);

        // assert
        expect(provider.state, RequestState.error);
        expect(provider.message, 'Server Failure');
        expect(listenerCallCount, 2);
      },
    );
  });

  group('reset tv search', () {
    test(
      'should reset state to empty state',
      () async {
        // act
        provider.resetTvSearch();

        // assert
        expect(provider.state, RequestState.empty);
        expect(provider.message, '');
        expect(provider.searchResult, []);
      },
    );
  });
}
