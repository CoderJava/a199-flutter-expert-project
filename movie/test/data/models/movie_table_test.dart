import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/movie_table.dart';

import '../../json_reader.dart';

void main() {
  const tModel = MovieTable(
    id: 1,
    title: 'testTitle',
    posterPath: '/path.jpg',
    overview: 'testOverview',
  );

  group('fromMap', () {
    test(
      'should return a valid model from JSON',
      () async {
        // arrange
        final jsonMap = json.decode(
          readJson('dummy_data/movie_table.json'),
        );

        // act
        final result = MovieTable.fromJson(jsonMap);

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
          'id': 1,
          'title': 'testTitle',
          'posterPath': '/path.jpg',
          'overview': 'testOverview',
        };
        expect(result, expectedJsonMap);
      },
    );
  });
}
