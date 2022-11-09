import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/genre_model.dart';

import '../../json_reader.dart';

void main() {
  const tModel = GenreModel(
    id: 1,
    name: 'testName',
  );

  group('fromJson', () {
    test(
      'should return a valid model from JSON',
      () async {
        // arrange
        final jsonMap = json.decode(readJson('dummy_data/genre_model.json'));

        // act
        final result = GenreModel.fromJson(jsonMap);

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
        final result = tModel.toJson();

        // assert
        final expectedJsonMap = {
          "id": 1,
          "name": 'testName',
        };
        expect(result, expectedJsonMap);
      },
    );
  });
}