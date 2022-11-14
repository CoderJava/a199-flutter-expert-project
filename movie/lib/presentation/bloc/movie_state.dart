part of 'movie_bloc.dart';

abstract class MovieState {}

class InitialMovieState extends MovieState {
  @override
  String toString() {
    return 'InitialMovieState{}';
  }
}

class LoadingMovieState extends MovieState {
  @override
  String toString() {
    return 'LoadingMovieState{}';
  }
}

class FailureMovieState extends MovieState {
  final String message;

  FailureMovieState({required this.message});

  @override
  String toString() {
    return 'FailureMovieState{message: $message}';
  }
}

class SuccessLoadDataHomeMovieState extends MovieState {
  final List<Movie> nowPlayingMovies;
  final List<Movie> popularMovies;
  final List<Movie> topRatedMovies;

  SuccessLoadDataHomeMovieState({
    required this.nowPlayingMovies,
    required this.popularMovies,
    required this.topRatedMovies,
  });

  @override
  String toString() {
    return 'SuccessLoadDataHomeMovieState{nowPlayingMovies: $nowPlayingMovies, popularMovies: $popularMovies, '
        'topRatedMovies: $topRatedMovies}';
  }
}

class SuccessLoadDataNowPlayingMovieState extends MovieState {
  final List<Movie> nowPlayingMovies;

  SuccessLoadDataNowPlayingMovieState({required this.nowPlayingMovies});

  @override
  String toString() {
    return 'SuccessLoadDataNowPlayingMovieState{nowPlayingMovies: $nowPlayingMovies}';
  }
}

class SuccessLoadDataPopularMovieState extends MovieState {
  final List<Movie> popularMovies;

  SuccessLoadDataPopularMovieState({required this.popularMovies});

  @override
  String toString() {
    return 'SuccessLoadDataPopularMovieState{popularMovies: $popularMovies}';
  }
}

class SuccessLoadDataTopRatedMovieState extends MovieState {
  final List<Movie> topRatedMovies;

  SuccessLoadDataTopRatedMovieState({required this.topRatedMovies});

  @override
  String toString() {
    return 'SuccessLoadDataTopRatedMovieState{topRatedMovies: $topRatedMovies}';
  }
}

class SuccessLoadDataDetailMovieState extends MovieState {
  final MovieDetail? movieDetail;
  final List<Movie> movieRecommendations;
  final bool isAddedToWatchlist;

  SuccessLoadDataDetailMovieState({
    required this.movieDetail,
    required this.movieRecommendations,
    required this.isAddedToWatchlist,
  });

  @override
  String toString() {
    return 'SuccessLoadDataDetailMovieState{movieDetail: $movieDetail, movieRecommendations: $movieRecommendations, '
        'isAddedToWatchlist: $isAddedToWatchlist}';
  }
}

class SuccessSearchMovieState extends MovieState {
  final List<Movie> searchResult;

  SuccessSearchMovieState({required this.searchResult});

  @override
  String toString() {
    return 'SuccessSearchMovieState{searchResult: $searchResult}';
  }
}

class SuccessLoadDataWatchlistMovieState extends MovieState {
  final List<Movie> watchlistMovies;

  SuccessLoadDataWatchlistMovieState({required this.watchlistMovies});

  @override
  String toString() {
    return 'SuccessLoadDataWatchlistMovieState{watchlistMovies: $watchlistMovies}';
  }
}

class SuccessUpdateWatchlistStatusMovieState extends MovieState {
  final String message;
  final bool isAddedToWatchlist;

  SuccessUpdateWatchlistStatusMovieState({
    required this.message,
    required this.isAddedToWatchlist,
  });

  @override
  String toString() {
    return 'SuccessUpdateWatchlistStatusMovieState{message: $message, isAddedToWatchlist: $isAddedToWatchlist}';
  }
}
