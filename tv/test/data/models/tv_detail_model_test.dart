import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv_detail_model.dart';

import '../../json_reader.dart';

void main() {
  const tPathJson = 'dummy_data/tv_detail_model.json';
  final tModel = TvDetailModel.fromJson(
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
      final actualModel = TvDetailModel.fromJson(jsonData);

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
        "adult": false,
        "backdrop_path": "/path.jpg",
        "created_by": [
          {"id": 1, "credit_id": "testCreditId", "name": "testName", "profile_path": "testProfilePath"}
        ],
        "episode_run_time": [1],
        "first_air_date": "testFirstAirDate",
        "genres": [
          {"id": 1, "name": "testName"}
        ],
        "homepage": "testHomePage",
        "id": 1,
        "languages": ["testLanguage"],
        "last_air_date": "testLastAirDate",
        "last_episode_to_air": {
          "air_date": "testAirDate",
          "episode_number": 1,
          "id": 1,
          "name": "testName",
          "overview": "testOverview",
          "runtime": 1,
          "season_number": 1,
          "show_id": 1,
          "still_path": "/path.jpg",
          "vote_average": 1.0,
          "vote_count": 1
        },
        "name": "testName",
        "networks": [
          {"id": 1, "name": "testName", "logo_path": "/path.jpg", "origin_country": "testOriginCountry"}
        ],
        "number_of_episodes": 1,
        "number_of_seasons": 1,
        "origin_country": ["testOriginCountry"],
        "original_language": "testOriginalLanguage",
        "original_name": "testOriginalName",
        "overview": "testOverview",
        "popularity": 1.0,
        "poster_path": "/path.jpg",
        "production_companies": [
          {"id": 1, "name": "testName", "logo_path": "/path.jpg", "origin_country": "testOriginCountry"}
        ],
        "production_countries": [
          {"iso_3166_1": "testIso", "name": "testName"}
        ],
        "seasons": [
          {
            "air_date": "testAirDate",
            "episode_count": 1,
            "id": 1,
            "name": "testName",
            "overview": "testOverview",
            "poster_path": "/path.jpg",
            "season_number": 1
          }
        ],
        "spoken_language": [
          {"english_name": "testEnglishName", "iso_639_1": "testIso", "name": "testName"}
        ],
        "status": "testStatus",
        "tagline": "testTagline",
        "type": "testType",
        "vote_average": 1.0,
        "vote_count": 1
      };
      expect(actualMap, json.encode(expectedAsMap));
    },
  );
}
