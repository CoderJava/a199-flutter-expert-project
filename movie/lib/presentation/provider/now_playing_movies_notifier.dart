import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';

class NowPlayingMoviesNotifier extends ChangeNotifier {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMoviesNotifier({required this.getNowPlayingMovies});

  RequestState _state = RequestState.empty;

  RequestState get state => _state;

  List<Movie> _movies = [];

  List<Movie> get movies => _movies;

  String _message = '';

  String get message => _message;

  Future<void> fetchNowPlayingMovies() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getNowPlayingMovies.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (moviesData) {
        _movies = moviesData;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
