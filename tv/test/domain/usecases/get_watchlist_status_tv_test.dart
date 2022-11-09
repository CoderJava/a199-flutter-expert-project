import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_watchlist_status_tv.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistStatusTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetWatchlistStatusTv(mockTvRepository);
  });

  test(
    'should get watchlist tatus from repository',
    () async {
      // arrange
      when(mockTvRepository.isAddedToWatchlist(1)).thenAnswer((_) async => true);

      // act
      final result = await usecase.execute(1);

      // assert
      expect(result, true);
    },
  );
}
