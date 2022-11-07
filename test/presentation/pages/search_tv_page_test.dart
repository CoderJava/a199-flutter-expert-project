import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/pages/search_tv_page.dart';
import 'package:ditonton/presentation/provider/tv_search_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_tv_page_test.mocks.dart';

@GenerateMocks([TvSearchNotifier])
void main() {
  late MockTvSearchNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvSearchNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvSearchNotifier>.value(
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

      await tester.pumpWidget(_makeTestableWidget(SearchTvPage()));

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

      await tester.pumpWidget(_makeTestableWidget(SearchTvPage()));
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
      when(mockNotifier.searchResult).thenReturn(<Tv>[]);

      final textFieldFinder = find.byType(TextField);
      final textFinder = find.byKey(Key('data_not_found'));

      await tester.pumpWidget(_makeTestableWidget(SearchTvPage()));
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
      when(mockNotifier.searchResult).thenReturn(testTvList);

      final textFieldFinder = find.byType(TextField);
      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(SearchTvPage()));
      await tester.press(textFieldFinder);
      await tester.enterText(textFieldFinder, 'query');
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);

      expect(textFieldFinder, findsOneWidget);
      expect(listViewFinder, findsOneWidget);
    },
  );
}
