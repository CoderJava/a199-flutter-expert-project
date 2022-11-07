import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/pages/search_movie_page.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_movie_page_test.mocks.dart';

@GenerateMocks([MovieSearchNotifier])
void main() {
  late MockMovieSearchNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockMovieSearchNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<MovieSearchNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Page should display empty container when empty state',
    (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.Empty);

      final containerFinder = find.byKey(Key('empty_container'));

      await tester.pumpWidget(_makeTestableWidget(SearchMoviePage()));

      expect(containerFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display center progress bar when loading',
    (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.Loading);

      final textFieldFinder = find.byType(TextField);
      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(SearchMoviePage()));
      await tester.press(textFieldFinder);
      await tester.enterText(textFieldFinder, 'query');
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);

      expect(textFieldFinder, findsOneWidget);
      expect(centerFinder, findsWidgets);
      expect(progressBarFinder, findsWidgets);
    },
  );

  testWidgets(
    'Page should display text Data not found when data is not available',
    (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.Loaded);
      when(mockNotifier.searchResult).thenReturn(<Movie>[]);

      final textFieldFinder = find.byType(TextField);
      final textFinder = find.byKey(Key('data_not_found'));

      await tester.pumpWidget(_makeTestableWidget(SearchMoviePage()));
      await tester.press(textFieldFinder);
      await tester.enterText(textFieldFinder, 'query');
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);

      expect(textFieldFinder, findsOneWidget);
      expect(textFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display ListView when data is loaded',
    (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.Loaded);
      when(mockNotifier.searchResult).thenReturn(testMovieList);

      final textFieldFinder = find.byType(TextField);
      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(SearchMoviePage()));
      await tester.press(textFieldFinder);
      await tester.enterText(textFieldFinder, 'query');
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);

      expect(textFieldFinder, findsOneWidget);
      expect(listViewFinder, findsOneWidget);
    },
  );
}
