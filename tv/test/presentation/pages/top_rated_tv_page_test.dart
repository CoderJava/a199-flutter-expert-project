void main() {
  // late MockTopRatedTvNotifier mockNotifier;
  //
  // setUp(() {
  //   mockNotifier = MockTopRatedTvNotifier();
  // });
  //
  // Widget makeTestableWidget(Widget body) {
  //   return ChangeNotifierProvider<TopRatedTvNotifier>.value(
  //     value: mockNotifier,
  //     child: MaterialApp(
  //       home: body,
  //     ),
  //   );
  // }
  //
  // testWidgets('Page should display progress bar when loading', (WidgetTester tester) async {
  //   when(mockNotifier.state).thenReturn(RequestState.loading);
  //
  //   final progressFinder = find.byType(CircularProgressIndicator);
  //   final centerFinder = find.byType(Center);
  //
  //   await tester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));
  //
  //   expect(centerFinder, findsOneWidget);
  //   expect(progressFinder, findsOneWidget);
  // });
  //
  // testWidgets('Page should display when data is loaded', (WidgetTester tester) async {
  //   when(mockNotifier.state).thenReturn(RequestState.loaded);
  //   when(mockNotifier.tv).thenReturn(<Tv>[]);
  //
  //   final listViewFinder = find.byType(ListView);
  //
  //   await tester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));
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
  //   await tester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));
  //
  //   expect(textFinder, findsOneWidget);
  // });
}
