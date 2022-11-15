import 'dart:convert';

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:tv/data/models/tv_detail_model.dart';
import 'package:tv/data/models/tv_response.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const baseUrl = 'https://api.themoviedb.org/3';

  late TvRemoteDataSourceImpl dataSource;
  late MockIOClient mockIOClient;

  setUp(() {
    mockIOClient = MockIOClient();
    dataSource = TvRemoteDataSourceImpl(client: mockIOClient);
  });

  group('get now playing tv', () {
    const tPathResponseJson = 'dummy_data/tv_response.json';
    final tTvList = TvResponse.fromJson(
      json.decode(
        readJson(tPathResponseJson),
      ),
    ).tvList;

    test(
      'pastikan mengembalikan data list tv ketika menerima respon kode 200',
      () async {
        // arrange
        when(mockIOClient.get(Uri.parse('$baseUrl/tv/airing_today?$apiKey')))
            .thenAnswer((_) async => http.Response(readJson(tPathResponseJson), 200));

        // act
        final result = await dataSource.getNowPlayingTv();

        // assert
        expect(result, equals(tTvList));
      },
    );

    test(
      'pastikan throw ServerException ketika menerima respon kode 404 atau yang lainnya',
      () async {
        // arrange
        when(mockIOClient.get(Uri.parse('$baseUrl/tv/airing_today?$apiKey')))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        // act
        final call = dataSource.getNowPlayingTv();

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get popular tv', () {
    const tPathResponseJson = 'dummy_data/tv_response.json';
    final tTvList = TvResponse.fromJson(
      json.decode(
        readJson(tPathResponseJson),
      ),
    ).tvList;

    test(
      'pastikan mengembalikan data list tv ketika menerima respon kode 200',
      () async {
        // arrange
        when(mockIOClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
            .thenAnswer((_) async => http.Response(readJson(tPathResponseJson), 200));

        // act
        final result = await dataSource.getPopularTv();

        // assert
        expect(result, equals(tTvList));
      },
    );

    test(
      'pastikan throw ServerException ketika menerima respon kode 404 atau yang lainnya',
      () async {
        // arrange
        when(mockIOClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        // act
        final call = dataSource.getPopularTv();

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get top rated tv', () {
    const tPathResponseJson = 'dummy_data/tv_response.json';
    final tTvList = TvResponse.fromJson(
      json.decode(
        readJson(tPathResponseJson),
      ),
    ).tvList;

    test(
      'pastikan mengembalikan data list tv ketika menerima respon kode 200',
      () async {
        // arrange
        when(mockIOClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
            .thenAnswer((_) async => http.Response(readJson(tPathResponseJson), 200));

        // act
        final result = await dataSource.getTopRatedTv();

        // assert
        expect(result, equals(tTvList));
      },
    );

    test(
      'pastikan throw ServerException ketika menerima respon kode 404 atau yang lainnya',
      () async {
        // arrange
        when(mockIOClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        // act
        final call = dataSource.getTopRatedTv();

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get tv detail', () {
    const tPathResponseJson = 'dummy_data/tv_detail_model.json';
    const tId = 1;
    final tTvDetail = TvDetailModel.fromJson(
      json.decode(
        readJson(tPathResponseJson),
      ),
    );

    test(
      'pastikan mengembalikan data detail tv ketika menerima respon kode 200',
      () async {
        // arrange
        when(mockIOClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
            .thenAnswer((_) async => http.Response(readJson(tPathResponseJson), 200));

        // act
        final result = await dataSource.getTvDetail(tId);

        // assert
        expect(result, equals(tTvDetail));
      },
    );

    test(
      'pastikan throw ServerException ketika menerima respon kode 404 atau yang lainnya',
      () async {
        // arrange
        when(mockIOClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        // act
        final call = dataSource.getTvDetail(tId);

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get tv recommendations', () {
    const tPathResponseJson = 'dummy_data/tv_response.json';
    const tId = 1;
    final tTvList = TvResponse.fromJson(
      json.decode(
        readJson(tPathResponseJson),
      ),
    ).tvList;

    test(
      'pastikan mengembalikan data list tv ketika menerima respon kode 200',
      () async {
        // arrange
        when(mockIOClient.get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
            .thenAnswer((_) async => http.Response(readJson(tPathResponseJson), 200));

        // act
        final result = await dataSource.getTvRecommendations(tId);

        // assert
        expect(result, equals(tTvList));
      },
    );

    test(
      'pastikan throw ServerException ketika menerima respon kode 404 atau yang lainnya',
      () async {
        // arrange
        when(mockIOClient.get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        // act
        final call = dataSource.getTvRecommendations(tId);

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('search tv', () {
    const tQuery = 'testQuery';
    const tPathResponseJson = 'dummy_data/tv_response.json';
    final tTvList = TvResponse.fromJson(
      json.decode(
        readJson(tPathResponseJson),
      ),
    ).tvList;

    test(
      'pastikan mengembalikan data list tv ketika menerima respon kode 200',
      () async {
        // arrange
        when(mockIOClient.get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')))
            .thenAnswer((_) async => http.Response(readJson(tPathResponseJson), 200));

        // act
        final result = await dataSource.searchTv(tQuery);

        // assert
        expect(result, equals(tTvList));
      },
    );

    test(
      'pastikan throw ServerException ketika menerima respon kode 404 atau yang lainnya',
      () async {
        // arrange
        when(mockIOClient.get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        // act
        final call = dataSource.searchTv(tQuery);

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });
}
