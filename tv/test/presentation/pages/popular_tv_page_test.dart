void main() {
  // late MockPopularTvNotifier mockNotifier;
  //
  // setUp(() {
  //   mockNotifier = MockPopularTvNotifier();
  // });
  //
  // Widget makeTestableWidget(Widget body) {
  //   return ChangeNotifierProvider<PopularTvNotifier>.value(
  //     value: mockNotifier,
  //     child: MaterialApp(
  //       home: body,
  //     ),
  //   );
  // }
  //
  // testWidgets('Page should display center progress bar when loading', (WidgetTester tester) async {
  //   when(mockNotifier.state).thenReturn(RequestState.loading);
  //
  //   final progressBarFinder = find.byType(CircularProgressIndicator);
  //   final centerFinder = find.byType(Center);
  //
  //   await tester.pumpWidget(makeTestableWidget(const PopularTvPage()));
  //
  //   expect(centerFinder, findsOneWidget);
  //   expect(progressBarFinder, findsOneWidget);
  // });
  //
  // testWidgets('Page should display ListView when data is loaded', (WidgetTester tester) async {
  //   when(mockNotifier.state).thenReturn(RequestState.loaded);
  //   when(mockNotifier.tv).thenReturn(<Tv>[]);
  //
  //   final listViewFinder = find.byType(ListView);
  //
  //   await tester.pumpWidget(makeTestableWidget(const PopularTvPage()));
  //
  //   expect(listViewFinder, findsOneWidget);
  // });
  //
  // testWidgets('Page should display text with message when Error', (WidgetTester tester) async {
  //   when(mockNotifier.state).thenReturn(RequestState.error);
  //   when(mockNotifier.message).thenReturn('Error message');
  //
  //   final textFinder = find.byKey(const Key('error_message'));
  //
  //   await tester.pumpWidget(makeTestableWidget(const PopularTvPage()));
  //
  //   expect(textFinder, findsOneWidget);
  // });
}
