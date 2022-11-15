void main() {
  // late MockMovieSearchNotifier mockNotifier;
  //
  // setUp(() {
  //   mockNotifier = MockMovieSearchNotifier();
  // });
  //
  // Widget makeTestableWidget(Widget body) {
  //   return ChangeNotifierProvider<MovieSearchNotifier>.value(
  //     value: mockNotifier,
  //     child: MaterialApp(
  //       home: body,
  //     ),
  //   );
  // }
  //
  // testWidgets(
  //   'Page should display empty container when empty state',
  //   (WidgetTester tester) async {
  //     when(mockNotifier.state).thenReturn(RequestState.empty);
  //
  //     final containerFinder = find.byKey(const Key('empty_container'));
  //
  //     await tester.pumpWidget(makeTestableWidget(const SearchMoviePage()));
  //
  //     expect(containerFinder, findsOneWidget);
  //   },
  // );
  //
  // testWidgets(
  //   'Page should display center progress bar when loading',
  //   (WidgetTester tester) async {
  //     when(mockNotifier.state).thenReturn(RequestState.loading);
  //
  //     final textFieldFinder = find.byType(TextField);
  //     final progressBarFinder = find.byType(CircularProgressIndicator);
  //     final centerFinder = find.byType(Center);
  //
  //     await tester.pumpWidget(makeTestableWidget(const SearchMoviePage()));
  //     await tester.press(textFieldFinder);
  //     await tester.enterText(textFieldFinder, 'query');
  //     await tester.sendKeyEvent(LogicalKeyboardKey.enter);
  //
  //     expect(textFieldFinder, findsOneWidget);
  //     expect(centerFinder, findsWidgets);
  //     expect(progressBarFinder, findsWidgets);
  //   },
  // );
  //
  // testWidgets(
  //   'Page should display text Data not found when data is not available',
  //   (WidgetTester tester) async {
  //     when(mockNotifier.state).thenReturn(RequestState.loaded);
  //     when(mockNotifier.searchResult).thenReturn(<Movie>[]);
  //
  //     final textFieldFinder = find.byType(TextField);
  //     final textFinder = find.byKey(const Key('data_not_found'));
  //
  //     await tester.pumpWidget(makeTestableWidget(const SearchMoviePage()));
  //     await tester.press(textFieldFinder);
  //     await tester.enterText(textFieldFinder, 'query');
  //     await tester.sendKeyEvent(LogicalKeyboardKey.enter);
  //
  //     expect(textFieldFinder, findsOneWidget);
  //     expect(textFinder, findsOneWidget);
  //   },
  // );
  //
  // testWidgets(
  //   'Page should display ListView when data is loaded',
  //   (WidgetTester tester) async {
  //     when(mockNotifier.state).thenReturn(RequestState.loaded);
  //     when(mockNotifier.searchResult).thenReturn(testMovieList);
  //
  //     final textFieldFinder = find.byType(TextField);
  //     final listViewFinder = find.byType(ListView);
  //
  //     await tester.pumpWidget(makeTestableWidget(const SearchMoviePage()));
  //     await tester.press(textFieldFinder);
  //     await tester.enterText(textFieldFinder, 'query');
  //     await tester.sendKeyEvent(LogicalKeyboardKey.enter);
  //
  //     expect(textFieldFinder, findsOneWidget);
  //     expect(listViewFinder, findsOneWidget);
  //   },
  // );
}
