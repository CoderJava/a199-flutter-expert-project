import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';

class WatchlistTvNotifier extends ChangeNotifier {
  final GetWatchlistTv getWatchlistTv;

  WatchlistTvNotifier({required this.getWatchlistTv});

  final _watchlistTv = <Tv>[];

  List<Tv> get watchlistTv => _watchlistTv;

  var _watchlistState = RequestState.empty;

  RequestState get watchlistState => _watchlistState;

  String _message = '';

  String get message => _message;

  Future<void> fetchWatchlistTv() async {
    _watchlistState = RequestState.loading;
    notifyListeners();

    final result = await getWatchlistTv.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _watchlistState = RequestState.loaded;
        _watchlistTv.clear();
        _watchlistTv.addAll(tvData);
        notifyListeners();
      },
    );
  }
}
