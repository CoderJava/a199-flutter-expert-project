import 'dart:convert';

import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  const tPathJson = 'dummy_data/tv_response.json';
  final tModel = TvResponse.fromJson(
    json.decode(
      readJson(tPathJson),
    ),
  );

  test(
    'pastikan fungsi fromJson bisa mengembalikan objek class model',
    () async {
      // arrange
      final jsonData = json.decode(
        readJson(tPathJson),
      );

      // act
      final actualModel = TvResponse.fromJson(jsonData);

      // assert
      expect(actualModel, tModel);
    },
  );

  test(
    'pastikan fungsi toJson bisa mengembalikan objek map',
    () async {
      // act
      final actualMap = json.encode(tModel.toJson());

      // assert
      final expectedAsMap = {
        "results": [
          {
            "backdrop_path": "/path.jpg",
            "first_air_date": "testFirstAirDate",
            "genre_ids": [1],
            "id": 1,
            "name": "testName",
            "original_country": ["testOriginalCountry"],
            "original_language": "testOriginalLanguage",
            "original_name": "testOriginalName",
            "overview": "testOverview",
            "popularity": 1.0,
            "poster_path": "/path.jpg",
            "vote_average": 1.0,
            "vote_count": 1
          }
        ]
      };
      expect(actualMap, json.encode(expectedAsMap));
    },
  );
}
