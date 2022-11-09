import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/genre_model.dart';
import 'package:movie/data/models/movie_detail_model.dart';

import '../../json_reader.dart';

void main() {
  const tModel = MovieDetailResponse(
    adult: false,
    backdropPath: '/path.jpg',
    budget: 0,
    genres: [
      GenreModel(
        id: 1,
        name: 'testName',
      ),
    ],
    homepage: 'testHomePage',
    id: 1,
    imdbId: 'testImdbId',
    originalLanguage: 'testOriginalLanguage',
    originalTitle: 'testOriginalTitle',
    overview: 'testOverview',
    popularity: 1.0,
    posterPath: '/path.jpg',
    releaseDate: '2020-05-05',
    revenue: 1,
    runtime: 1,
    status: 'testStatus',
    tagline: 'testTagline',
    title: 'testTitle',
    video: false,
    voteAverage: 1.0,
    voteCount: 1,
  );

  group('fromJson', () {
    test(
      'should return a valid model from JSON',
      () async {
        // arrange
        final jsonMap = json.decode(
          readJson(
            'dummy_data/movie_detail_model.json',
          ),
        );

        // act
        final result = MovieDetailResponse.fromJson(jsonMap);

        // assert
        expect(result, tModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing proper data',
      () async {
        // act
        final result = json.encode(tModel.toJson());

        // assert
        final expectedJsonMap = {
          'adult': false,
          'backdrop_path': '/path.jpg',
          'budget': 0,
          'genres': [
            {
              'id': 1,
              'name': 'testName',
            }
          ],
          'homepage': 'testHomePage',
          'id': 1,
          'imdb_id': 'testImdbId',
          'original_language': 'testOriginalLanguage',
          'original_title': 'testOriginalTitle',
          'overview': 'testOverview',
          'popularity': 1.0,
          'poster_path': '/path.jpg',
          'release_date': '2020-05-05',
          'revenue': 1,
          'runtime': 1,
          'status': 'testStatus',
          'tagline': 'testTagline',
          'title': 'testTitle',
          'video': false,
          'vote_average': 1.0,
          'vote_count': 1,
        };
        expect(result, json.encode(expectedJsonMap));
      },
    );
  });
}
