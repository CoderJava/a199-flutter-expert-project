import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';

class NowPlayingTvNotifier extends ChangeNotifier {
  final GetNowPlayingTv getNowPlayingTv;

  NowPlayingTvNotifier({required this.getNowPlayingTv});

  RequestState _state = RequestState.empty;

  RequestState get state => _state;

  List<Tv> _tv = [];

  List<Tv> get tv => _tv;

  String _message = '';

  String get message => _message;

  Future<void> fetchNowPlayingTv() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getNowPlayingTv.execute();
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (tvData) {
        _tv = tvData;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
