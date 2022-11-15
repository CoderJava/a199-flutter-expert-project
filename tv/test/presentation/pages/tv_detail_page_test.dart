void main() {
  // late MockTvDetailNotifier mockNotifier;
  //
  // setUp(() {
  //   mockNotifier = MockTvDetailNotifier();
  // });
  //
  // Widget makeTestableWidget(Widget body) {
  //   return ChangeNotifierProvider<TvDetailNotifier>.value(
  //     value: mockNotifier,
  //     child: MaterialApp(
  //       home: body,
  //     ),
  //   );
  // }
  //
  // testWidgets('Watchlist button should display add icon when tv not added to watchlist',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.tvState).thenReturn(RequestState.loaded);
  //   when(mockNotifier.tv).thenReturn(testTvDetail);
  //   when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
  //   when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
  //   when(mockNotifier.isAddedToWatchlist).thenReturn(false);
  //
  //   final watchlistButtonIcon = find.byIcon(Icons.add);
  //
  //   await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));
  //
  //   expect(watchlistButtonIcon, findsOneWidget);
  // });
  //
  // testWidgets(
  //   'Loading center should display when tv loading',
  //   (WidgetTester tester) async {
  //     when(mockNotifier.tvState).thenReturn(RequestState.loading);
  //
  //     final circularProgressIndicator = find.byType(CircularProgressIndicator);
  //
  //     await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));
  //
  //     expect(circularProgressIndicator, findsOneWidget);
  //   },
  // );
  //
  // testWidgets(
  //   'Error message should display when tv failure loaded',
  //   (WidgetTester tester) async {
  //     when(mockNotifier.tvState).thenReturn(RequestState.error);
  //     when(mockNotifier.message).thenReturn('Server Failure');
  //
  //     final text = find.text('Server Failure');
  //
  //     await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));
  //
  //     expect(text, findsOneWidget);
  //   },
  // );
  //
  // testWidgets('Watchlist button should display check icon when tv is added to wathclist', (WidgetTester tester) async {
  //   when(mockNotifier.tvState).thenReturn(RequestState.loaded);
  //   when(mockNotifier.tv).thenReturn(testTvDetail);
  //   when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
  //   when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
  //   when(mockNotifier.isAddedToWatchlist).thenReturn(true);
  //
  //   final watchlistButtonIcon = find.byIcon(Icons.check);
  //
  //   await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));
  //
  //   expect(watchlistButtonIcon, findsOneWidget);
  // });
  //
  // testWidgets('Watchlist button should display Snackbar when added to watchlist', (WidgetTester tester) async {
  //   when(mockNotifier.tvState).thenReturn(RequestState.loaded);
  //   when(mockNotifier.tv).thenReturn(testTvDetail);
  //   when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
  //   when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
  //   when(mockNotifier.isAddedToWatchlist).thenReturn(false);
  //   when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');
  //
  //   final watchlistButton = find.byType(ElevatedButton);
  //
  //   await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));
  //
  //   expect(find.byIcon(Icons.add), findsOneWidget);
  //
  //   await tester.tap(watchlistButton);
  //   await tester.pump();
  //
  //   expect(find.byType(SnackBar), findsOneWidget);
  //   expect(find.text('Added to Watchlist'), findsOneWidget);
  // });
  //
  // testWidgets('Watchlist button should display AlertDialog when add to watchlist failed', (WidgetTester tester) async {
  //   when(mockNotifier.tvState).thenReturn(RequestState.loaded);
  //   when(mockNotifier.tv).thenReturn(testTvDetail);
  //   when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
  //   when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
  //   when(mockNotifier.isAddedToWatchlist).thenReturn(false);
  //   when(mockNotifier.watchlistMessage).thenReturn('Failed');
  //
  //   final watchlistButton = find.byType(ElevatedButton);
  //
  //   await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));
  //
  //   expect(find.byIcon(Icons.add), findsOneWidget);
  //
  //   await tester.tap(watchlistButton);
  //   await tester.pump();
  //
  //   expect(find.byType(AlertDialog), findsOneWidget);
  //   expect(find.text('Failed'), findsOneWidget);
  // });
}
