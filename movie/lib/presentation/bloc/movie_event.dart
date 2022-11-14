part of 'movie_bloc.dart';

abstract class MovieEvent {}

class LoadDataHomeMovieEvent extends MovieEvent {

  @override
  String toString() {
    return 'LoadDataHomeMovieEvent{}';
  }
}

class LoadDataNowPlayingMovieEvent extends MovieEvent {

  @override
  String toString() {
    return 'LoadDataNowPlayingMovieEvent{}';
  }
}

class LoadDataPopularMovieEvent extends MovieEvent {

  @override
  String toString() {
    return 'LoadDataPopularMovieEvent{}';
  }
}

class LoadDataTopRatedMovieEvent extends MovieEvent {

  @override
  String toString() {
    return 'LoadDataTopRatedMovieEvent{}';
  }
}

class LoadDataDetailMovieEvent extends MovieEvent {
  final int id;

  LoadDataDetailMovieEvent({required this.id});

  @override
  String toString() {
    return 'LoadDataDetailMovieEvent{id: $id}';
  }
}

class SearchMovieEvent extends MovieEvent {
  final String query;

  SearchMovieEvent({required this.query});

  @override
  String toString() {
    return 'SearchMovieEvent{query: $query}';
  }
}

class LoadDataWatchlistMovieEvent extends MovieEvent {

  @override
  String toString() {
    return 'LoadDataWatchlistMovieEvent{}';
  }
}

class AddWatchlistMovieEvent extends MovieEvent {
  final MovieDetail movie;

  AddWatchlistMovieEvent({required this.movie});

  @override
  String toString() {
    return 'AddWatchlistMovieEvent{movie: $movie}';
  }
}

class RemoveWatchlistMovieEvent extends MovieEvent {
  final MovieDetail movie;

  RemoveWatchlistMovieEvent({required this.movie});

  @override
  String toString() {
    return 'RemoveWatchlistMovieEvent{movie: $movie}';
  }
}