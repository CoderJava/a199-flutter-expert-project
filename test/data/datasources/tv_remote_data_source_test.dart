import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvRemoteDataSourceImpl(client: mockHttpClient);
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
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
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
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
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
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
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
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
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
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
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
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
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
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
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
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
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
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
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
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
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
        when(mockHttpClient.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
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
        when(mockHttpClient.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        // act
        final call = dataSource.searchTv(tQuery);

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });
}
