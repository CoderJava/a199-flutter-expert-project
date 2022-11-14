part of 'tv_bloc.dart';

abstract class TvEvent {}

class LoadDataHomeTvEvent extends TvEvent {

  @override
  String toString() {
    return 'LoadDataHomeTvEvent{}';
  }
}

class LoadDataNowPlayingTvEvent extends TvEvent {

  @override
  String toString() {
    return 'LoadDataNowPlayingTvEvent{}';
  }
}

class LoadDataPopularTvEvent extends TvEvent {

  @override
  String toString() {
    return 'LoadDataPopularTvEvent{}';
  }
}

class LoadDataTopRatedTvEvent extends TvEvent {

  @override
  String toString() {
    return 'LoadDataTopRatedTvEvent{}';
  }
}

class LoadDataDetailTvEvent extends TvEvent {
  final int id;

  LoadDataDetailTvEvent({required this.id});

  @override
  String toString() {
    return 'LoadDataDetailTvEvent{id: $id}';
  }
}

class SearchTvEvent extends TvEvent {
  final String query;

  SearchTvEvent({required this.query});

  @override
  String toString() {
    return 'SearchTvEvent{query: $query}';
  }
}

class LoadDataWatchlistTvEvent extends TvEvent {

  @override
  String toString() {
    return 'LoadDataWatchlistTvEvent{}';
  }
}

class AddWatchlistTvEvent extends TvEvent {
  final TvDetail tv;

  AddWatchlistTvEvent({required this.tv});

  @override
  String toString() {
    return 'AddWatchlistTvEvent{tv: $tv}';
  }
}

class RemoveWatchlistTvEvent extends TvEvent {
  final TvDetail tv;

  RemoveWatchlistTvEvent({required this.tv});

  @override
  String toString() {
    return 'RemoveWatchlistTvEvent{tv: $tv}';
  }
}