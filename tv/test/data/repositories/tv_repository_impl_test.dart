import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/data/models/genre_model.dart';
import 'package:tv/data/models/tv_detail_model.dart';
import 'package:tv/data/models/tv_model.dart';
import 'package:tv/data/repositories/tv_repository_impl.dart';
import 'package:tv/domain/entities/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvRepositoryImpl repository;
  late MockTvRemoteDataSource mockRemoteDataSource;
  late MockTvLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvRemoteDataSource();
    mockLocalDataSource = MockTvLocalDataSource();
    repository = TvRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  const tTvModel = TvModel(
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

  final tTv = Tv(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: const [1, 2],
    id: 1,
    name: 'name',
    originalCountry: const [
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

  final tTvModelList = <TvModel>[tTvModel];
  final tTvList = <Tv>[tTv];
  const tConnectionMessage = 'Failed to connect to the network';

  group('Now Playing tv', () {
    test('should return remote data when the call to remote data source is successful', () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTv()).thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getNowPlayingTv();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTv());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTv()).thenThrow(ServerException());
      // act
      final result = await repository.getNowPlayingTv();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTv());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('should return connection failure when the device is not connected to internet', () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTv()).thenThrow(const SocketException(tConnectionMessage));
      // act
      final result = await repository.getNowPlayingTv();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTv());
      expect(result, equals(Left(ConnectionFailure(tConnectionMessage))));
    });
  });

  group('Popular tv', () {
    test('should return tv list when call to data source is success', () async {
      // arrange
      when(mockRemoteDataSource.getPopularTv()).thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getPopularTv();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return server failure when call to data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.getPopularTv()).thenThrow(ServerException());
      // act
      final result = await repository.getPopularTv();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test('should return connection failure when device is not connected to the internet', () async {
      // arrange
      when(mockRemoteDataSource.getPopularTv()).thenThrow(const SocketException(tConnectionMessage));
      // act
      final result = await repository.getPopularTv();
      // assert
      expect(result, Left(ConnectionFailure(tConnectionMessage)));
    });
  });

  group('Top Rated tv', () {
    test('should return tv list when call to data source is successful', () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTv()).thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getTopRatedTv();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTv()).thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTv();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test('should return ConnectionFailure when device is not connected to the internet', () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTv()).thenThrow(const SocketException(tConnectionMessage));
      // act
      final result = await repository.getTopRatedTv();
      // assert
      expect(result, Left(ConnectionFailure(tConnectionMessage)));
    });
  });

  group('Get tv Detail', () {
    const tId = 1;
    const tTvResponse = TvDetailModel(
      isAdult: false,
      backdropPath: 'backdropPath',
      createdBy: [
        CreatedByModel(
          id: 1,
          creditId: 'creditId',
          name: 'name',
          profilePath: 'profilePath',
        ),
      ],
      episodeRuntime: [1],
      firstAirDate: 'firstAirDate',
      genres: [
        GenreModel(
          id: 1,
          name: 'name',
        ),
      ],
      homepage: 'homepage',
      id: 1,
      languages: ['languages'],
      lastAirDate: 'lastAirDate',
      lastEpisodeToAir: LastEpisodeToAirModel(
        airDate: 'airDate',
        episodeNumber: 1,
        id: 1,
        name: 'name',
        overview: 'overview',
        runtime: 1,
        seasonNumber: 1,
        showId: 1,
        stillPath: 'stillPath',
        voteAverage: 1.0,
        voteCount: 1,
      ),
      name: 'name',
      networks: [
        NetworkModel(
          id: 1,
          name: 'name',
          logoPath: 'logoPath',
          originCountry: 'originCountry',
        ),
      ],
      numberOfEpisodes: 1,
      numberOfSeasons: 1,
      originCountry: ['originCountry'],
      originalLanguage: 'originalLanguage',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1.0,
      posterPath: 'posterPath',
      productionCompanies: [
        NetworkModel(
          id: 1,
          name: 'name',
          logoPath: 'logoPath',
          originCountry: 'originCountry',
        ),
      ],
      productionCountries: [
        ProductionCountriesModel(
          iso: 'iso',
          name: 'name',
        ),
      ],
      seasons: [
        SeasonModel(
          airDate: 'airDate',
          episodeCount: 1,
          id: 1,
          name: 'name',
          overview: 'overview',
          posterPath: 'posterPath',
          seasonNumber: 1,
        ),
      ],
      spokenLanguage: [
        SpokenLanguageModel(
          englishName: 'englishName',
          iso: 'iso',
          name: 'name',
        ),
      ],
      status: 'status',
      tagline: 'tagline',
      type: 'type',
      voteAverage: 1.0,
      voteCount: 1,
    );

    test('should return tv data when the call to remote data source is successful', () async {
      // arrange
      when(mockRemoteDataSource.getTvDetail(tId)).thenAnswer((_) async => tTvResponse);
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvDetail(tId));
      expect(result, equals(const Right(testTvDetail)));
    });

    test('should return Server Failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.getTvDetail(tId)).thenThrow(ServerException());
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('should return connection failure when the device is not connected to internet', () async {
      // arrange
      when(mockRemoteDataSource.getTvDetail(tId)).thenThrow(const SocketException(tConnectionMessage));
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvDetail(tId));
      expect(result, equals(Left(ConnectionFailure(tConnectionMessage))));
    });
  });

  group('Get tv Recommendations', () {
    final tTvList = <TvModel>[];
    const tId = 1;

    test('should return data (tv list) when the call is successful', () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId)).thenAnswer((_) async => tTvList);
      // act
      final result = await repository.getTvRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvList));
    });

    test('should return server failure when call to remote data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId)).thenThrow(ServerException());
      // act
      final result = await repository.getTvRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('should return connection failure when the device is not connected to the internet', () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(const SocketException(tConnectionMessage));
      // act
      final result = await repository.getTvRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      expect(result, equals(Left(ConnectionFailure(tConnectionMessage))));
    });
  });

  group('Search tv', () {
    const tQuery = 'query';

    test('should return tv list when call to data source is successful', () async {
      // arrange
      when(mockRemoteDataSource.searchTv(tQuery)).thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.searchTv(tQuery);
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.searchTv(tQuery)).thenThrow(ServerException());
      // act
      final result = await repository.searchTv(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test('should return ConnectionFailure when device is not connected to the internet', () async {
      // arrange
      when(mockRemoteDataSource.searchTv(tQuery)).thenThrow(const SocketException(tConnectionMessage));
      // act
      final result = await repository.searchTv(tQuery);
      // assert
      expect(result, Left(ConnectionFailure(tConnectionMessage)));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTvTable)).thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTvDetail);
      // assert
      expect(result, const Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTvTable)).thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testTvDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTvTable)).thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testTvDetail);
      // assert
      expect(result, const Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTvTable)).thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testTvDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const tId = 1;
      when(mockLocalDataSource.getTvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist tv', () {
    test('should return list of tv', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTv()).thenAnswer((_) async => [testTvTable]);
      // act
      final result = await repository.getWatchlistTv();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTv]);
    });
  });
}
