import 'dart:convert';

import 'package:ditonton/data/models/tv_table.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  const tPathJson = 'dummy_data/tv_table.json';
  final tModel = TvTable.fromJson(
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
      final actualModel = TvTable.fromJson(jsonData);

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
        "id": 1,
        "name": "testName",
        "posterPath": "testPosterPath",
        "overview": "testOverview",
      };
      expect(actualMap, json.encode(expectedAsMap));
    },
  );
}
